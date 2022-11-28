import Foundation
import AdventCore
import Collections

public struct School {
    var fish: Deque<Int>

    mutating func tick() {
        let current = fish.removeFirst()
        fish[6] += current
        fish.append(current)
    }

    public static func simulate(ages: [Int], days: Int) -> Int {
        var fish = Deque(repeating: 0, count: 9)
        for age in ages {
            fish[age] += 1
        }
        var school = School(fish: fish)
        for _ in 0..<days {
            school.tick()
        }
        return school.fish.sum()
    }
}


fileprivate let day6_input: [Int] = Bundle.module.text(named: "day6").lines()[0].commaSeparated().ints()

public func day6_1() -> Int {
    School.simulate(ages: day6_input, days: 80)
}

public func day6_2() -> Int {
    School.simulate(ages: day6_input, days: 256)
}
