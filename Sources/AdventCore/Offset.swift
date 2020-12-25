import Foundation

public struct Offset {
    var east: Int = 0
    var north: Int = 0

    public init(east: Int = 0, north: Int = 0) {
        self.east = east
        self.north = north
    }

    public mutating func rotate(angle: Int) {
        let newEast =
            east * Int(cos(Double.pi * Double(angle)/180.0)) -
            north * Int(sin(Double.pi * Double(angle)/180.0))
        let newNorth =
            east * Int(sin(Double.pi * Double(angle)/180.0)) +
            north * Int(cos(Double.pi * Double(angle)/180.0))
        self = Offset(east: newEast, north: newNorth)
    }

    public func manhattanDistance(to other: Offset) -> Int {
        let difference = other - self
        return abs(difference.east) + abs(difference.north)
    }
}

extension Offset : AdditiveArithmetic {
    public static func - (lhs: Offset, rhs: Offset) -> Offset {
        Offset(east: lhs.east - rhs.east, north: lhs.north - rhs.north)
    }

    public static func + (lhs: Offset, rhs: Offset) -> Offset {
        Offset(east: lhs.east + rhs.east, north: lhs.north + rhs.north)
    }

    public static var zero: Offset {
        Offset()
    }
}

extension Offset {
    public static func * (lhs: Int, rhs: Offset) -> Offset {
        Offset(east: lhs * rhs.east, north: lhs * rhs.north)
    }
}
