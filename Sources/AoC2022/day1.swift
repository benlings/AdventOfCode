import Foundation
import AdventCore

public struct Inventory {
    var calories: [[Int]]

    public func mostCalories() -> Int? {
        calories.map { $0.sum() }.max()
    }
}

public extension Inventory {
    init(_ input: String) {
        calories = input.groups().map { $0.lines().ints() }
    }
}

fileprivate let day1_input = Bundle.module.text(named: "day1")

public func day1_1() -> Int {
    Inventory(day1_input).mostCalories()!
}

public func day1_2() -> Int {
    0
}
