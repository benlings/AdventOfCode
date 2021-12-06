import Foundation
import AdventCore

struct LanternFish {
    var timer: Int = 8

    mutating func tick() -> LanternFish? {
        if timer == 0 {
            timer = 6
            return LanternFish()
        } else {
            timer -= 1
            return nil
        }
    }
}

public struct School {
    var fish: [LanternFish]

    mutating func tick() {
        var spawned = [LanternFish]()
        for i in fish.indices {
            let new = fish[i].tick()
            if let new = new {
                spawned.append(new)
            }
        }
        fish += spawned
    }

    public static func simulate(ages: [Int], days: Int) -> Int {
        var school = School(fish: ages.map(LanternFish.init))
        for _ in 0..<days {
            school.tick()
        }
        return school.fish.count
    }
}


fileprivate let day6_input: [Int] = Bundle.module.text(named: "day6").lines()[0].commaSeparated().ints()

public func day6_1() -> Int {
    School.simulate(ages: day6_input, days: 80)
}

public func day6_2() -> Int {
    0
}
