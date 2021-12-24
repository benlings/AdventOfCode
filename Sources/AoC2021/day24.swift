import Foundation
import AdventCore

//inp a - Read an input value and write it to variable a.
//add a b - Add the value of a to the value of b, then store the result in variable a.
//mul a b - Multiply the value of a by the value of b, then store the result in variable a.
//div a b - Divide the value of a by the value of b, truncate the result to an integer, then store the result in variable a. (Here, "truncate" means to round the value toward zero.)
//mod a b - Divide the value of a by the value of b, then store the remainder in variable a. (This is also called the modulo operation.)
//eql a b - If the value of a and b are equal, then store the value 1 in variable a. Otherwise, store the value 0 in variable a.

enum Variable : Character {
    case w = "w", x = "x", y = "y", z = "z"
}

enum Value {
    case literal(Int)
    case variable(Variable)
}

enum BinaryOperation : String {
    case add
    case mul
    case div
    case mod
    case eql
}

enum Instruction {
    case inp(a: Variable)
    case binary(op: BinaryOperation, a: Variable, b: Value)
}

extension Instruction {
    init?(_ description: String) {
        if let i = Scanner(string: description).scanInstruction() {
            self = i
        } else {
            return nil
        }
    }
}

public struct ArithmeticLogicUnit {

    var instructions: [Instruction]

    var variables: [Variable : Int] = [
        .w : 0,
        .x : 0,
        .y : 0,
        .z : 0,
    ]

}

extension ArithmeticLogicUnit {
    public init(_ description: String) {
        self.instructions = description.lines().compactMap(Instruction.init)
    }
}

fileprivate extension Scanner {
    func scanInstruction() -> Instruction? {
        guard let name = scanUpToCharacters(from: .whitespaces) else { return nil }
        switch name {
        case "inp":
            return scanVariable().map { .inp(a: $0) }
        default:
            guard let op = BinaryOperation(rawValue: name),
                  let a = scanVariable(),
                  let b = scanValue()
            else { return nil }
            return .binary(op: op, a: a, b: b)
        }
    }

    func scanVariable() -> Variable? {
        scanCharacter().flatMap { Variable(rawValue: $0) }
    }

    func scanValue() -> Value? {
        if let literal = scanInt() {
            return .literal(literal)
        } else if let variable = scanVariable() {
            return .variable(variable)
        } else {
            return nil
        }
    }
}

fileprivate let day24_input = Bundle.module.text(named: "day24")

public func day24_1() -> Int {
    _ = ArithmeticLogicUnit(day24_input)
    return 0
}

public func day24_2() -> Int {
    0
}
