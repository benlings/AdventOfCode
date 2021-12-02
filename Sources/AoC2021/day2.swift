import Foundation
import AdventCore

enum Action {
    case down(Int)
    case forward(Int)
}

extension Action {
    init?(_ description: String) {
        let scanner = Scanner(string: description)
        guard let c = scanner.scanUpToCharacters(from: .whitespaces),
              let n = scanner.scanInt() else {
            return nil
        }
        switch c {
        case "forward":
            self = .forward(n)
        case "down":
            self = .down(n)
        case "up":
            self = .down(-n)
        default:
            return nil
        }
    }
}


struct Submarine {
    var position: Offset = .zero
}

extension Submarine {
    mutating func move(following actions: [Action]) {
        for action in actions {
            switch action {
            case .forward(let x):
                position += Offset(north: x)
            case .down(let y):
                position += Offset(east: y)
            }
        }
    }

    func distanceProduct() -> Int {
        position.distanceProduct()
    }
}

func parseInstructions(_ lines: [String]) -> [Action] {
    lines.compactMap(Action.init)
}

public func distanceProduct(followingInstructions input: [String]) -> Int {
    let instructions = parseInstructions(input)
    var submarine = Submarine()
    submarine.move(following: instructions)
    return submarine.distanceProduct()
}

fileprivate let day2_input = Bundle.module.text(named: "day2").lines()

public func day2_1() -> Int {
    distanceProduct(followingInstructions: day2_input)
}

public func day2_2() -> Int {
    0
}
