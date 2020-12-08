import Foundation
import AdventCore

enum Operation {
    case nop
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
            return .nop
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
}

public struct Instructions {

    var operations: [Operation]

    public func eval(_ context: inout Context) {
        var visitedLines = Set<Int>()
        while !visitedLines.contains(context.line) {
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
