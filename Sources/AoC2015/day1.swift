import Foundation
import AdventCore

public struct Elevator {
    let instructions: String

    public var finalFloor: Int {
        instructions.count(of: "(") - instructions.count(of: ")")
    }

    public var floors: [Int] {
        instructions.scan(0) { floor, c in
            if c == "(" {
                return floor + 1
            }
            if c == ")" {
                return floor - 1
            }
            return floor
        }
    }

    public func index(reachingFloor: Int) -> Int? {
        floors.firstIndex(of: reachingFloor)
    }
}

fileprivate let day1_input = Bundle.module.text(named: "day1")

public func day1_1() -> Int {
    Elevator(instructions: day1_input).finalFloor
}

public func day1_2() -> Int {
    Elevator(instructions: day1_input).index(reachingFloor: -1)!
}
