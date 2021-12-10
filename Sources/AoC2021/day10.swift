import Foundation
import AdventCore

public struct NavigationSystem {
    var lines: [String]

    public enum SyntaxError {
        case incorrectClosing(Character)
        case incomplete([Character])
    }

    public func findErrors() -> [SyntaxError] {
        let matching: [Character : Character] = [
            ")" : "(",
            "}" : "{",
            "]" : "[",
            ">" : "<",
        ]
        return lines.compactMap { line in
            let scanner = Scanner(string: line)
            scanner.charactersToBeSkipped = nil
            var stack = [Character]()
            while let c = scanner.scanCharacter() {
                let matched = matching[c]
                if let opening = matched { // Found closing delimiter
                    guard let last = stack.popLast() else { return nil }
                    if opening != last {
                        return .incorrectClosing(c)
                    }
                } else { // Found opening delimiter
                    stack.append(c)
                }
            }
            return .incomplete(stack.reversed())
        }
    }

    public func incorrectClosingCharacters() -> [Character] {
        findErrors().compactMap { e in
            switch e {
            case .incorrectClosing(let c): return c
            default: return nil
            }
        }
    }

    public func incomplete() -> [[Character]] {
        findErrors().compactMap { e in
            switch e {
            case .incomplete(let cs): return cs
            default: return nil
            }
        }
    }

    public func incorrectClosingCharacterScores() -> Int {
        let scores: [Character : Int] = [
            ")" : 3,
            "]" : 57,
            "}" : 1197,
            ">" : 25137,
        ]
        return incorrectClosingCharacters().compactMap { scores[$0] }.sum()
    }

    public func incompleteScores() -> [Int] {
        let scores: [Character : Int] = [
            "(" : 1,
            "[" : 2,
            "{" : 3,
            "<" : 4,
        ]
        return incomplete().map {
            $0.compactMap { scores[$0] }.reduce(0) {
                $0 * 5 + $1
            }
        }
    }

}

extension NavigationSystem {
    public init(_ description: String) {
        self.lines = description.lines()
    }
}

fileprivate let day10_input = Bundle.module.text(named: "day10")

public func day10_1() -> Int {
    NavigationSystem(day10_input).incorrectClosingCharacterScores()
}

public func day10_2() -> Int {
    NavigationSystem(day10_input).incompleteScores().median()!
}
