import Foundation
import Algorithms
import AdventCore

fileprivate let day6_input = Bundle.module.text(named: "day6")

public func findStartOfPacket(_ input: String) -> Int? {
    let windows = Array(input).windows(ofCount: 4)
    let i = windows.firstIndex { $0.toSet().count == 4 }
    guard let i else { return nil }
    let start = windows.distance(from: windows.startIndex, to: i)
    return start + 4
}

public func day6_1() -> Int {
    findStartOfPacket(day6_input)!
}

public func day6_2() -> Int {
    0
}
