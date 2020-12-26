import Foundation
import AdventCore

enum Movement : String {
    case north = "^"
    case south = "v"
    case east = ">"
    case west = "<"

    var offset: Offset {
        switch self {
        case .north: return Offset(north: 1)
        case .south: return Offset(north: -1)
        case .east: return Offset(east: 1)
        case .west: return Offset(east: -1)
        }
    }
}

public struct DeliveryRoute {
    var moves: [Movement]

    static func follow<T : Sequence>(route: T) -> [Offset : Int] where T.Element == Movement {
        var position = Offset.zero
        var houses = [position : 1]
        for move in route {
            position += move.offset
            houses[position, default: 0] += 1
        }
        return houses
    }

    public var countHouses: Int {
        Self.follow(route: moves).count
    }

    public var countHouses2: Int {
        let santa = Self.follow(route: moves.striding(by: 2))
        let robot = Self.follow(route: moves.dropFirst().striding(by: 2))
        return santa.merging(robot, uniquingKeysWith: +).count
    }
}

public extension DeliveryRoute {
    init(_ description: String) {
        moves = description.compactMap { Movement(rawValue: String($0)) }
    }
}

fileprivate let input = Bundle.module.text(named: "day3")

public func day3_1() -> Int {
    DeliveryRoute(input).countHouses
}

public func day3_2() -> Int {
    DeliveryRoute(input).countHouses2
}
