import Foundation
import Algorithms
import AdventCore

public func findStart(_ input: String, distinct: Int = 4) -> Int? {
    Array(input)
        .windows(ofCount: distinct)
        .first { $0.toSet().count == distinct }?
        .endIndex
}

public func day6_1(_ input: String) -> Int {
    findStart(input)!
}

public func day6_2(_ input: String) -> Int {
    findStart(input, distinct: 14)!
}
