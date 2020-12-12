import Foundation

struct Offset {
    var east: Int = 0
    var north: Int = 0

    mutating func rotate(angle: Int) {
        let newEast =
            east * Int(cos(Double.pi * Double(angle)/180.0)) -
            north * Int(sin(Double.pi * Double(angle)/180.0))
        let newNorth =
            east * Int(sin(Double.pi * Double(angle)/180.0)) +
            north * Int(cos(Double.pi * Double(angle)/180.0))
        self = Offset(east: newEast, north: newNorth)
    }

    func manhattanDistance(to other: Offset) -> Int {
        let difference = other - self
        return abs(difference.east) + abs(difference.north)
    }
}

extension Offset : AdditiveArithmetic {
    static func - (lhs: Offset, rhs: Offset) -> Offset {
        Offset(east: lhs.east - rhs.east, north: lhs.north - rhs.north)
    }

    static func + (lhs: Offset, rhs: Offset) -> Offset {
        Offset(east: lhs.east + rhs.east, north: lhs.north + rhs.north)
    }

    static var zero: Offset {
        Offset()
    }
}

extension Offset {
    static func * (lhs: Int, rhs: Offset) -> Offset {
        Offset(east: lhs * rhs.east, north: lhs * rhs.north)
    }
}
