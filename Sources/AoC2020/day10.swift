import Foundation
import AdventCore
import Algorithms

public func differences(_ numbers: [Int]) -> [Int : Int] {
    let sortedNumbers = numbers.sorted()
    let allNumbers = chain(chain([0], sortedNumbers), [sortedNumbers.last! + 3])
    return Dictionary(grouping: allNumbers.slidingWindows(ofCount: 2).map { $0.last! - $0.first! }, by: { $0 })
        .mapValues { $0.count }
}

public func differencesProduct(_ numbers: [Int]) -> Int {
    let d = differences(numbers)
    return d[1]! * d[3]!
}

fileprivate let input = Bundle.module.text(named: "day10").lines().ints()

public func day10_1() -> Int {
    differencesProduct(input)
}

public func day10_2() -> Int {
    0
}
