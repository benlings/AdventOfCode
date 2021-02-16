import Foundation
import AdventCore

public struct Matchsticks {

    var lines: [String]

    public func excessCharacters() -> Int {
        lines.map { (line: String) in
            2 + 3 * line.count(of: #"\x"#) + line.count(of: #"\""#)
        }.sum()
    }

}

public extension Matchsticks {
    init(_ description: String) {
        lines = description.lines()
    }
}

public func day8_1() -> Int {
    0
}

public func day8_2() -> Int {
    0
}
