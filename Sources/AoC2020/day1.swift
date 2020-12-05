import Foundation
import AdventCore

fileprivate let day1_input = Bundle.module.text(named: "day1").lines()

public func day1_1() -> Int {
    let numbers = day1_input.compactMap { Int($0) }.lazy
    let match = numbers.flatMap { n1 in
        numbers.map { n2 in (n1, n2) }
    }.first { (n1, n2) in n1 + n2 == 2020 }!
    return match.0 * match.1
}

public func day1_2() -> Int {
    let numbers = day1_input.compactMap { Int($0) }.lazy
    let match2 = numbers.flatMap { n1 in
        numbers.flatMap { n2 in
            numbers.map { n3 in (n1, n2, n3) }
        }
    }.first { (nums: (Int, Int, Int)) -> Bool in nums.0 + nums.1 + nums.2 == 2020 }!
    return match2.0 * match2.1 * match2.2
}
