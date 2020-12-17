import Foundation
import AdventCore

public struct PointND : Hashable {
    var coords: [Int]

    static func zero(_ dimensions: Int) -> PointND {
        PointND(coords: .init(repeating: 0, count: dimensions))
    }

    subscript(dimension: Int) -> Int {
        get {
            coords[dimension]
        }
        set {
            coords[dimension] = newValue
        }
    }

    static func - (lhs: PointND, rhs: OffsetND) -> PointND {
        PointND(coords: zip(lhs.coords, rhs.d).map(-))
    }

    static func + (lhs: PointND, rhs: OffsetND) -> PointND {
        PointND(coords: zip(lhs.coords, rhs.d).map(+))
    }
}

public struct OffsetND : Hashable {
    var d: [Int]

    static func one(dim: Int, of dimensions: Int) -> OffsetND {
        var offset = zero(dimensions)
        offset.d[dim] = 1
        return offset
    }

    subscript(dimension: Int) -> Int {
        get {
            d[dimension]
        }
        set {
            d[dimension] = newValue
        }
    }

    static func neighboursIncZero(_ dimensions: Int) -> [OffsetND] {
        if dimensions == 1 {
            return [
                OffsetND(d: [-1]),
                OffsetND(d: [0]),
                OffsetND(d: [1]),
            ]
        } else {
            return neighboursIncZero(dimensions - 1).flatMap { n in
                [
                    OffsetND(d: n.d + [-1]),
                    OffsetND(d: n.d + [0]),
                    OffsetND(d: n.d + [1]),
                ]
            }
        }
    }

    static func neighbours(_ dimensions: Int) -> [OffsetND] {
        neighboursIncZero(dimensions).filter {
            $0 != .zero(dimensions)
        }
    }

    static func zero(_ dimensions: Int) -> OffsetND {
        OffsetND(d: [Int](repeating: 0, count: dimensions))
    }
    static func one(_ dimensions: Int) -> OffsetND {
        OffsetND(d: [Int](repeating: 1, count: dimensions))
    }

    static func - (lhs: OffsetND, rhs: OffsetND) -> OffsetND {
        OffsetND(d: zip(lhs.d, rhs.d).map(-))
    }
    static func + (lhs: OffsetND, rhs: OffsetND) -> OffsetND {
        OffsetND(d: zip(lhs.d, rhs.d).map(+))
    }
    static func * (lhs: Int, rhs: OffsetND) -> OffsetND {
        OffsetND(d: rhs.d.map { lhs * $0 })
    }
    static prefix func - (rhs: OffsetND) -> OffsetND {
        OffsetND(d: rhs.d.map { -$0 })
    }
    static prefix func + (rhs: OffsetND) -> OffsetND {
        rhs
    }

}

public struct RangeND : Hashable {
    var origin: PointND
    var extent: OffsetND

    static func empty(_ dimensions: Int) -> RangeND {
        RangeND(origin: .zero(dimensions), extent: .zero(dimensions))
    }

    public func inset(_ change: OffsetND) -> RangeND {
        RangeND(origin: origin + change, extent: extent - 2 * change)
    }

    func forEach(_ action: (PointND) -> Void) {
        if (origin.coords.count == 3) {
            for x in origin[0]...(origin[0] + extent[0]) {
                for y in origin[1]...(origin[1] + extent[1]) {
                    for z in origin[2]...(origin[2] + extent[2]) {
                        action(PointND(coords: [x, y, z]))
                    }
                }
            }
        } else {
            // FIXME
            for x in origin[0]...(origin[0] + extent[0]) {
                for y in origin[1]...(origin[1] + extent[1]) {
                    for z in origin[2]...(origin[2] + extent[2]) {
                        for w in origin[3]...(origin[3] + extent[3]) {
                            action(PointND(coords: [x, y, z, w]))
                        }
                    }
                }
            }
        }
    }
}

public struct GridND {
    var active: Set<PointND>
    let dimensions: Int

    var range: RangeND {
        var r = RangeND.empty(dimensions)
        for d in 0..<dimensions {
            r.origin[d] = active.map { $0[d] }.min() ?? 0
            r.extent[d] = (active.map { $0[d] }.max() ?? 0) - r.origin[d]
        }
        return r
    }

    func map(_ action: (Bool, PointND) -> Bool) -> GridND {
        let newRange = self.range.inset(-.one(dimensions))
        var newCells = Set<PointND>()
        newRange.forEach { point in
            if action(active.contains(point), point) {
                newCells.insert(point)
            }
        }
        return GridND(active: newCells, dimensions: dimensions)
    }

    func countNeighbours(point: PointND) -> Int {
        OffsetND.neighbours(dimensions).map {
            self.active.contains(point + $0) ? 1 : 0
        }.sum()
    }

    public mutating func step() {
        self = self.map { (active, point) -> Bool in
            let neighbours = countNeighbours(point: point)
            if active {
                return neighbours == 2 || neighbours == 3
            } else {
                return neighbours == 3
            }
        }
    }

    public mutating func boot() {
        for _ in 0..<6 {
            step()
        }
    }

    public func countActive() -> Int {
        active.count
    }
}

public extension GridND {
    init(_ description: String, dimensions: Int = 3) {
        self = .init(active: description
                        .lines()
                        .enumerated()
                        .flatMap { (y, line) in
                            Array(line).enumerated().compactMap { (x, cell) -> PointND? in
                                if cell == "#" {
                                    var coords = [Int](repeating: 0, count: dimensions)
                                    coords[0] = x
                                    coords[1] = y
                                    return PointND(coords: coords)
                                } else {
                                    return nil
                                }
                            }
                        }
                        .toSet(),
                     dimensions: dimensions)
    }
}

fileprivate let input = Bundle.module.text(named: "day17")

public func day17_1() -> Int {
    var grid = GridND(input)
    grid.boot()
    return grid.countActive()
}

public func day17_2() -> Int {
    0
}
