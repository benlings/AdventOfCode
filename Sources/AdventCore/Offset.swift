import Foundation

public struct Offset {
    public var east: Int = 0
    public var north: Int = 0

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

    public func distanceProduct() -> Int {
        return north * east
    }
}

extension Offset : Comparable {
    public static func < (lhs: Offset, rhs: Offset) -> Bool {
        (lhs.north, lhs.east) < (rhs.north, rhs.east)
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

extension Offset : Hashable {
}

extension Offset {
    public static func * (lhs: Int, rhs: Offset) -> Offset {
        Offset(east: lhs * rhs.east, north: lhs * rhs.north)
    }
}

public struct OffsetRange {
    public init(southWest: Offset, northEast: Offset) {
        self.southWest = southWest
        self.northEast = northEast
    }

    var southWest: Offset
    var northEast: Offset
}

extension OffsetRange : Collection {
    public typealias Index = Offset
    public typealias Element = Offset

    public var startIndex: Offset {
        southWest
    }

    public var endIndex: Offset {
        northEast + Offset(east: 1)
    }

    public subscript(position: Offset) -> Offset {
        precondition(position.east >= southWest.east && position.east <= northEast.east)
        precondition(position.north >= southWest.north && position.north <= northEast.north)
        return position
    }

    public func index(after i: Offset) -> Offset {
        if i.east < northEast.east {
            return i + Offset(east: 1)
        }
        if i.north < northEast.north {
            return Offset(east: southWest.east, north: i.north + 1)
        }
        return endIndex
    }

}
