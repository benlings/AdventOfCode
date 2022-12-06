import Foundation
import AdventCore

public struct XMASCypher {
    public init(preamble: Int, input: [Int]) {
        self.preamble = preamble
        self.input = input
    }

    let preamble: Int
    let input: [Int]

    public func firstInvalid() -> Int? {
        let windows = input.windows(ofCount: preamble + 1)
        return windows.first { window in
            !window.dropLast()
                .combinations(ofCount: 2)
                .contains { $0.sum() == window.last }
        }?.last
    }

    public func findRange(summingTo total: Int) -> Array<Int>.SubSequence? {
        let minSize = 2
        var start = input.startIndex, end = start + minSize
        var sum = input[start..<end].sum()
        while start <= input.endIndex - minSize && end < input.endIndex {
            if sum == total {
                return input[start..<end]
            }
            if sum > total {
                sum -= input[start]
                start += 1
            } else {
                sum += input[end]
                end += 1
            }
        }
        return nil
    }

    public static func encryptionWeakness(_ range: some Collection<Int>) -> Int {
        range.min()! + range.max()!
    }
}

fileprivate let day9_input: [Int] = Bundle.module.text(named: "day9").lines().ints()

public func day9_1() -> Int {
    XMASCypher(preamble: 25, input: day9_input).firstInvalid()!
}

public func day9_2() -> Int {
    let cypher = XMASCypher(preamble: 25, input: day9_input)
    let result = cypher.findRange(summingTo: cypher.firstInvalid()!)!
    return XMASCypher.encryptionWeakness(result)
}
