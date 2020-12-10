import Foundation
import AdventCore
import Algorithms

public func differences(_ numbers: [Int]) -> [Int : Int] {
    let sortedNumbers = numbers.sorted()
    let allNumbers = chain(chain([0], sortedNumbers), [sortedNumbers.last! + 3])
    return allNumbers
        .slidingWindows(ofCount: 2)
        .map { $0.last! - $0.first! }
        .group(by: { $0 })
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
    let sortedNumbers = input.sorted()
    let allNumbers = chain(chain([0], sortedNumbers), [sortedNumbers.last! + 3])
    let diff = allNumbers.slidingWindows(ofCount: 2)
            .map { $0.last! - $0.first! }
    return diff.split { $0 != 1 }.map { $0.count }.map {
        switch $0 {
        case 1: return 1
        case 2: return 2
        case 3: return 4
        case 4: return 7
        default: preconditionFailure()
        }
    }.product()
}
