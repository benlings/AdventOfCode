import Foundation
import AdventCore

struct XMASCypher {
    let preamble: Int

    func findFirstInvalid(from numbers:[Int]) -> Int? {
        let windows = numbers.slidingWindows(ofCount: preamble + 1)
        return windows.first { window in
            !window.dropLast()
                .combinations(ofCount: 2)
                .contains { $0.sum() == window.last }
        }?.last
    }
}

fileprivate let day9_input = Bundle.module.text(named: "day9").lines().compactMap(Int.init)

public func day9_1() -> Int {
    XMASCypher(preamble: 25).findFirstInvalid(from: day9_input)!
}

public func day9_2() -> Int {
    0
}
