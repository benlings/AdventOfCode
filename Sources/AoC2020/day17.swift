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

    public func boot() -> Int {
        aliveCount(iterations: 6)
    }
}

extension GridND : GameOfLife {
    typealias Coordinate = PointND

    var initialWorld: World {
        active
    }

    func neighbours(coordinate: Coordinate) -> [Coordinate] {
        OffsetND.neighbours(dimensions).map { coordinate + $0 }
    }

    func alive(wasAlive alive: Bool, neighbours count: Int) -> Bool {
        alive ? count == 2 || count == 3 : count == 3
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
    return GridND(input).boot()
}

public func day17_2() -> Int {
    return GridND(input, dimensions: 4).boot()
}
