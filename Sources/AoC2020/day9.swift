import Foundation
import AdventCore

struct XMASCypher {
    let preamble: Int
    let input: [Int]

    func firstInvalid() -> Int? {
        let windows = input.slidingWindows(ofCount: preamble + 1)
        return windows.first { window in
            !window.dropLast()
                .combinations(ofCount: 2)
                .contains { $0.sum() == window.last }
        }?.last
    }

    func findRange(summingTo sum: Int) -> [Int]? {
        for start in input.startIndex..<(input.endIndex - 2) {
            for end in (start + 2)..<input.endIndex {
                let range = start..<end
                let subArray = input[range]
                let subSum = subArray.sum()
                if subSum == sum {
                    return Array(subArray)
                }
                if subSum > sum {
                    break
                }
            }
        }
        return nil
    }

    static func encryptionWeakness(_ range: [Int]) -> Int {
        range.min()! + range.max()!
    }
}

fileprivate let day9_input = Bundle.module.text(named: "day9").lines().compactMap(Int.init)

public func day9_1() -> Int {
    XMASCypher(preamble: 25, input: day9_input).firstInvalid()!
}

public func day9_2() -> Int {
    let cypher = XMASCypher(preamble: 25, input: day9_input)
    let result = cypher.findRange(summingTo: cypher.firstInvalid()!)!
    return XMASCypher.encryptionWeakness(result)
}
