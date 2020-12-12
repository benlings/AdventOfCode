import Foundation
import AdventCore

enum Action {
    case north(Int)
    case east(Int)
    case left(Int)
    case forward(Int)
}

extension Action {
    init?(_ description: String) {
        let scanner = Scanner(string: description)
        guard let c = scanner.scanCharacter(),
              let n = scanner.scanInt() else {
            return nil
        }
        switch c {
        case "N":
            self = .north(n)
        case "S":
            self = .north(-n)
        case "E":
            self = .east(n)
        case "W":
            self = .east(-n)
        case "L":
            self = .left(n)
        case "R":
            self = .left(-n)
        case "F":
            self = .forward(n)
        default:
            return nil
        }
    }
}

struct Position {
    var longitude: Int = 0 // east west
    var latitude: Int  = 0 // north south
    var heading: Int = 0 // anticlockwise to east
}

extension Position {
    mutating func move(following actions: [Action]) {
        for action in actions {
            switch action {
            case .north(let distance):
                latitude += distance
            case .east(let distance):
                longitude += distance
            case .left(let angle):
                heading += angle
            case .forward(let distance):
                longitude += distance * Int(cos(Double.pi * Double(heading)/180.0))
                latitude += distance * Int(sin(Double.pi * Double(heading)/180.0))
            }
        }
    }
    func manhattanDistanceToOrigin() -> Int {
        abs(latitude) + abs(longitude)
    }
}

func parseInstructions(_ lines: [String]) -> [Action] {
    lines.compactMap(Action.init)
}

func distance(followingInstructions input: String) -> Int {
    let instructions = parseInstructions(input.lines())
    var position = Position()
    position.move(following: instructions)
    return position.manhattanDistanceToOrigin()
}

fileprivate let input = Bundle.module.text(named: "day12")

public func day12_1() -> Int {
    distance(followingInstructions: input)
}

public func day12_2() -> Int {
    0
}
