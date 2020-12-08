import Foundation
import AdventCore

enum Operation {
    case nop(Int)
    case acc(Int)
    case jmp(Int)

    static func parse(_ input: String) -> Operation? {
        let scanner = Scanner(string: input)
        guard let opCode = scanner.scanUpToCharacters(from: .whitespaces),
              let operand = scanner.scanInt() else {
            return nil
        }
        switch opCode {
        case "nop":
            return .nop(operand)
        case "acc":
            return .acc(operand)
        case "jmp":
            return .jmp(operand)
        default:
            return nil
        }
    }

    func eval(context: inout Context) {
        switch self {
        case .nop:
            context.line += 1
            return
        case .acc(let value):
            context.accumulator += value
            context.line += 1
            return
        case .jmp(let value):
            context.line += value
            return
        }
    }

    mutating func swap() -> Bool {
        switch self {
        case .nop(let value):
            self = .jmp(value)
        case .jmp(let value):
            self = .nop(value)
        case .acc(_):
            return false
        }
        return true
    }
}

public struct Instructions {

    var operations: [Operation]

    mutating func switchOperation(at index: Int) -> Bool {
        operations[index].swap()
    }

    public mutating func fixProgram() -> Int {
        let originalSelf = self
        for i in operations.indices {
            self = originalSelf
            if switchOperation(at: i) {
                var context = Context()
                eval(&context)
                if context.line >= operations.count {
                    return context.accumulator
                }
            }
        }
        preconditionFailure()
    }

    public func execute() -> Int {
        var context = Context()
        eval(&context)
        return context.accumulator
    }

    public func eval(_ context: inout Context) {
        var visitedLines = Set<Int>()
        while !visitedLines.contains(context.line) && context.line < operations.count {
            visitedLines.insert(context.line)
            operations[context.line].eval(context: &context)
        }
    }
}

public extension Instructions {
    init(_ input: String) {
        self = .init(operations: input.lines().compactMap(Operation.parse))
    }
}

public struct Context {
    var line: Int = 0
    var accumulator: Int = 0
}

fileprivate let day8_input = Bundle.module.text(named: "day8")

public func day8_1() -> Int {
    return Instructions(day8_input).execute()
}

public func day8_2() -> Int {
    var instructions = Instructions(day8_input)
    return instructions.fixProgram()
}
