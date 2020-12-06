import Foundation
import AdventCore

public struct Elevator {
    let instructions: String

    public var finalFloor: Int {
        instructions.count(of: "(") - instructions.count(of: ")")
    }
}

fileprivate let day1_input = Bundle.module.text(named: "day1")

public func day1_1() -> Int {
    Elevator(instructions: day1_input).finalFloor
}
