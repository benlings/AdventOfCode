import Foundation
import AdventCore

public struct DeliveryRoute {
    var moves: [Offset]

    static func follow(route: [Offset]) -> [Offset : Int] {
        var position = Offset.zero
        var houses = [position : 1]
        for move in route {
            position += move
            houses[position, default: 0] += 1
        }
        return houses
    }

    public var countHouses: Int {
        Self.follow(route: moves).count
    }
}

public extension DeliveryRoute {
    init(_ description: String) {
        moves = description.compactMap {
            switch $0 {
            case "^": return Offset(north: 1)
            case ">": return Offset(east: 1)
            case "v": return Offset(north: -1)
            case "<": return Offset(east: -1)
            default: return nil
            }
        }
    }
}

fileprivate let input = Bundle.module.text(named: "day3")

public func day3_1() -> Int {
    DeliveryRoute(input).countHouses
}

public func day3_2() -> Int {
    0
}
