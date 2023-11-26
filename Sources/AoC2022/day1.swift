import Foundation
import AdventCore

struct Inventory {
    var calories: [[Int]]

    func calorieGroups() -> [Int] {
        calories.map { $0.sum() }
    }

    func mostCalories() -> Int? {
        calorieGroups().max()
    }

    func mostCalories(count: Int) -> Int? {
        calorieGroups().max(count: count).sum()
    }
}

extension Inventory {
    init(_ input: String) {
        calories = input.groups().map { $0.lines().ints() }
    }
}

public func day1_1(_ input: String) -> Int {
    Inventory(input).mostCalories()!
}

public func day1_2(_ input: String) -> Int {
    Inventory(input).mostCalories(count: 3)!
}
