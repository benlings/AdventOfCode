import Foundation
import AdventCore

enum Action {
    case move(Offset)
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
            self = .move(Offset(north: n))
        case "S":
            self = .move(Offset(north: -n))
        case "E":
            self = .move(Offset(east: n))
        case "W":
            self = .move(Offset(east: -n))
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


struct Ship {
    var position: Offset = .zero
    var heading: Offset = .init(east: 1)
    var waypoint = Offset(east: 10, north: 1)
}

extension Ship {
    mutating func move(following actions: [Action]) {
        for action in actions {
            switch action {
            case .move(let offset):
                position += offset
            case .left(let angle):
                heading.rotate(angle: angle)
            case .forward(let distance):
                position += distance * heading
            }
        }
    }

    mutating func move(followingWaypoint actions: [Action]) {
        for action in actions {
            switch action {
            case .move(let offset):
                waypoint += offset
            case .left(let angle):
                waypoint.rotate(angle: angle)
            case .forward(let distance):
                position += distance * waypoint
            }
        }
    }

    func manhattanDistanceToOrigin() -> Int {
        position.manhattanDistance(to: .zero)
    }
}

func parseInstructions(_ lines: [String]) -> [Action] {
    lines.compactMap(Action.init)
}

public func distance(followingInstructions input: String) -> Int {
    let instructions = parseInstructions(input.lines())
    var ship = Ship()
    ship.move(following: instructions)
    return ship.manhattanDistanceToOrigin()
}

public func distance(followingWaypointInstructions input: String) -> Int {
    let instructions = parseInstructions(input.lines())
    var ship = Ship()
    ship.move(followingWaypoint: instructions)
    return ship.manhattanDistanceToOrigin()
}

fileprivate let input = Bundle.module.text(named: "day12")

public func day12_1() -> Int {
    distance(followingInstructions: input)
}

public func day12_2() -> Int {
    distance(followingWaypointInstructions: input)
}
