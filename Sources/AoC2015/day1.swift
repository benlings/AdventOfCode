import Foundation
import AdventCore

public func elevator(_ instructions: String) -> Int {
    instructions.count(of: "(") - instructions.count(of: ")")
}

fileprivate let day1_input = Bundle.module.text(named: "day1")

public func day1_1() -> Int {
    elevator(day1_input)
}
