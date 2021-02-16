import Foundation
import AdventCore

public struct Matchsticks {

    var lines: [String]

    public func excessCharacters() -> Int {
        lines.map { (line: String) in
            2 + line.repl + 3 * line.count(of: #"\x"#) + line.count(of: #"\""#)
        }.sum()
    }

}

public extension Matchsticks {
    init(_ description: String) {
        lines = description.lines()
    }
}

fileprivate let input = Bundle.module.text(named: "day8")

public func day8_1() -> Int {
    Matchsticks(input).excessCharacters()
}

public func day8_2() -> Int {
    0
}
