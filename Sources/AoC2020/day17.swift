import Foundation
import AdventCore

public struct PointND : Hashable {
    var coords: [Int]

    static func + (lhs: PointND, rhs: OffsetND) -> PointND {
        PointND(coords: zip(lhs.coords, rhs.d).map(+))
    }
}

public struct OffsetND : Hashable {
    var d: [Int]

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
}

public struct GridND {
    var active: Set<PointND>
    let dimensions: Int

    public mutating func step() {
        var neighbours = [PointND : Int]()
        for point in active {
            for n in OffsetND.neighbours(dimensions) {
                neighbours[point + n, default: 0] += 1
            }
        }
        var newActive = Set<PointND>()
        for (point, count) in neighbours {
            if active.contains(point) ? count == 2 || count == 3 : count == 3 {
                newActive.insert(point)
            }
        }
        active = newActive
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
    var grid = GridND(input, dimensions: 4)
    grid.boot()
    return grid.countActive()
}
