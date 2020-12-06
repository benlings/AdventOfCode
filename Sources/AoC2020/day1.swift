import Foundation
import AdventCore

fileprivate let day1_input = Bundle.module.text(named: "day1").lines()

public func day1_1() -> Int {
    let numbers = day1_input.compactMap { Int($0) }
    return numbers.combinations(ofCount: 2)
        .first { $0.sum() == 2020 }!
        .product()
}

public func day1_2() -> Int {
    let numbers = day1_input.compactMap { Int($0) }
    return numbers.combinations(ofCount: 3)
        .first { $0.sum() == 2020 }!
        .product()
}
