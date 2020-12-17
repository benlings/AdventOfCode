import Foundation
import AdventCore

public struct Point3D : Hashable {
    var x = 0
    var y = 0
    var z = 0

    static let zero = Point3D()

    static func - (lhs: Point3D, rhs: Offset3D) -> Point3D {
        Point3D(x: lhs.x - rhs.dx, y: lhs.y - rhs.dy, z: lhs.z - rhs.dz)
    }

    static func + (lhs: Point3D, rhs: Offset3D) -> Point3D {
        Point3D(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy, z: lhs.z + rhs.dz)
    }
}

public struct Offset3D : Hashable {
    var dx = 0
    var dy = 0
    var dz = 0

    static let oneX = Offset3D(dx: 1, dy: 0, dz: 0)
    static let oneY = Offset3D(dx: 0, dy: 1, dz: 0)
    static let oneZ = Offset3D(dx: 0, dy: 0, dz: 1)

    static let neighbours: [Offset3D] = [
        -.oneX - .oneY - .oneZ, -.oneX - .oneY + .zero, -.oneX - .oneY + .oneZ,
        -.oneX - .zero - .oneZ, -.oneX - .zero + .zero, -.oneX - .zero + .oneZ,
        -.oneX + .oneY - .oneZ, -.oneX + .oneY + .zero, -.oneX + .oneY + .oneZ,
        +.zero - .oneY - .oneZ, +.zero - .oneY + .zero, +.zero - .oneY + .oneZ,
        +.zero - .zero - .oneZ,                         +.zero - .zero + .oneZ,
        +.zero + .oneY - .oneZ, +.zero + .oneY + .zero, +.zero + .oneY + .oneZ,
        +.oneX - .oneY - .oneZ, +.oneX - .oneY + .zero, +.oneX - .oneY + .oneZ,
        +.oneX - .zero - .oneZ, +.oneX - .zero + .zero, +.oneX - .zero + .oneZ,
        +.oneX + .oneY - .oneZ, +.oneX + .oneY + .zero, +.oneX + .oneY + .oneZ,
    ]

    static let zero = Offset3D()
    static let one = Offset3D(dx: 1, dy: 1, dz: 1)

    static func - (lhs: Offset3D, rhs: Offset3D) -> Offset3D {
        Offset3D(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy, dz: lhs.dz - rhs.dz)
    }
    static func + (lhs: Offset3D, rhs: Offset3D) -> Offset3D {
        Offset3D(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy, dz: lhs.dz + rhs.dz)
    }
    static func * (lhs: Int, rhs: Offset3D) -> Offset3D {
        Offset3D(dx: lhs * rhs.dx, dy: lhs * rhs.dy, dz: lhs * rhs.dz)
    }
    static prefix func - (rhs: Offset3D) -> Offset3D {
        Offset3D(dx: -rhs.dx, dy: -rhs.dy, dz: -rhs.dz)
    }
    static prefix func + (rhs: Offset3D) -> Offset3D {
        rhs
    }

}

public struct Range3D : Hashable {
    var origin: Point3D = .zero
    var extent: Offset3D = .zero

    static let empty = Range3D()

    public func inset(_ change: Offset3D) -> Range3D {
        Range3D(origin: origin + change, extent: extent - 2 * change)
    }

    func forEach(_ action: (Point3D) -> Void) {
        for x in origin.x...(origin.x + extent.dx) {
            for y in origin.y...(origin.y + extent.dy) {
                for z in origin.z...(origin.z + extent.dz) {
                    action(Point3D(x: x, y: y, z: z))
                }
            }
        }
    }
}

public struct Grid3D {
    var active: Set<Point3D>

    var range: Range3D {
        var r = Range3D.empty
        r.origin.x = active.map(\.x).min() ?? 0
        r.extent.dx = (active.map(\.x).max() ?? 0) - r.origin.x
        r.origin.y = active.map(\.y).min() ?? 0
        r.extent.dy = (active.map(\.y).max() ?? 0) - r.origin.y
        r.origin.z = active.map(\.z).min() ?? 0
        r.extent.dz = (active.map(\.z).max() ?? 0) - r.origin.z
        return r
    }

    func map(_ action: (Bool, Point3D) -> Bool) -> Grid3D {
        let newRange = self.range.inset(-.one)
        var newCells = Set<Point3D>()
        newRange.forEach { point in
            if action(active.contains(point), point) {
                newCells.insert(point)
            }
        }
        return Grid3D(active: newCells)
    }

    func countNeighbours(point: Point3D) -> Int {
        Offset3D.neighbours.map {
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

public extension Grid3D {
    init(_ description: String) {
        active = description
            .lines()
            .enumerated()
            .flatMap { (y, line) in
                Array(line).enumerated().compactMap { (x, cell) -> Point3D? in
                    cell == "#" ? Point3D(x: x, y: y, z: 0) : nil
                }
            }
            .toSet()
    }
}

fileprivate let input = Bundle.module.text(named: "day17")

public func day17_1() -> Int {
    var grid = Grid3D(input)
    grid.boot()
    return grid.countActive()
}

public func day17_2() -> Int {
    0
}
