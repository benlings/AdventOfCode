import Foundation
import Algorithms
import AdventCore

fileprivate let day6_input = Bundle.module.text(named: "day6")

public func findStart(_ input: String, distinct: Int = 4) -> Int? {
    let windows = Array(input).windows(ofCount: distinct)
    let i = windows.firstIndex { $0.toSet().count == distinct }
    guard let i else { return nil }
    let start = windows.distance(from: windows.startIndex, to: i)
    return start + distinct
}

public func day6_1() -> Int {
    findStart(day6_input)!
}

public func day6_2() -> Int {
    findStart(day6_input, distinct: 14)!
}
