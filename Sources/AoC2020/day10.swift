import Foundation
import AdventCore
import Algorithms

public func differences(_ numbers: [Int]) -> [Int : Int] {
    let sortedNumbers = numbers.sorted()
    let allNumbers = chain(chain([0], sortedNumbers), [sortedNumbers.last! + 3])
    return allNumbers
        .windows(ofCount: 2)
        .map { $0.last! - $0.first! }
        .group(by: { $0 })
        .mapValues { $0.count }
}

public func differencesProduct(_ numbers: [Int]) -> Int {
    let d = differences(numbers)
    return d[1]! * d[3]!
}

fileprivate let input: [Int] = Bundle.module.text(named: "day10").lines().ints()

public func day10_1() -> Int {
    differencesProduct(input)
}

/// Combinations of ways of rearranging adapters with difference of 1
func combinations3(_ count: Int) -> Int {
    assert(count > 0)
    switch count {   // Arrangements of differences between consecutive adapters
    case 1: return 1 // 1
    case 2: return 2 // 1 <case 1>, 2
    case 3: return 4 // 1 <case 2>, 2 <case 1>, 3
    // 1 <case n-1>, 2 <case n-2>, 3 <case n-3>
    default: return combinations3(count - 1) + combinations3(count - 2) + combinations3(count - 3)
    }
}

public func day10_2() -> Int {
    let sortedNumbers = input.sorted()
    let allNumbers = chain(chain([0], sortedNumbers), [sortedNumbers.last! + 3])
    let diff = allNumbers.windows(ofCount: 2)
            .map { $0.last! - $0.first! }
    return diff
        .split { $0 != 1 }
        .map(\.count)
        .map(combinations3)
        .product()
}
