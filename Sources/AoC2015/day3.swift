import Foundation
import AdventCore

public struct DeliveryRoute {
    var moves: [Offset]

    public var countHouses: Int {
        var position = Offset.zero
        var houses = [position : 1]
        for move in moves {
            position += move
            houses[position, default: 0] += 1
        }
        return houses.count
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
