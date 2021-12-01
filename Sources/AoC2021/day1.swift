import Foundation
import AdventCore

public func countIncreasedDepth(_ depths: [Int]) -> Int {
    depths.adjacentPairs().count { $1 > $0 }
}

public func countIncreasedDepthWindowed(_ depths: [Int]) -> Int {
    countIncreasedDepth(depths.windows(ofCount: 3).map { $0.sum() })
}

fileprivate let day1_input: [Int] = Bundle.module.text(named: "day1").lines().ints()

public func day1_1() -> Int {
    countIncreasedDepth(day1_input)
}

public func day1_2() -> Int {
    countIncreasedDepthWindowed(day1_input)
}
