import Foundation
import AdventCore

public struct LightGrid {
    var instructions: [Instruction]

    public func evaluate() -> Set<Offset> {
        var lights = Set<Offset>()
        for instruction in instructions {
            instruction.evaluate(lights: &lights)
        }
        return lights
    }

}

public extension LightGrid {

    enum Operation {
        case turnOn
        case turnOff
        case toggle

        func evaluate(offset: Offset, lights: inout Set<Offset>) {
            switch self {
            case .turnOn:
                lights.insert(offset)
            case .turnOff:
                lights.remove(offset)
            case .toggle:
                lights.toggle(offset)
            }
        }
    }

    struct Instruction {
        var operation: Operation
        var range: OffsetRange

        func evaluate(lights: inout Set<Offset>) {
            range.forEach { operation.evaluate(offset: $0, lights: &lights) }
        }
    }
}

public extension LightGrid {
    init(_ description: String) {
        instructions = description.lines().compactMap(Instruction.init)
    }
}

extension Scanner {
    func scanInstruction() -> LightGrid.Instruction? {
        guard let op = scanOperation(),
              let range = scanOffsetRange() else {
            return nil
        }
        return LightGrid.Instruction(operation: op, range: range)
    }

    func scanOperation() -> LightGrid.Operation? {
        if let _ = scanString("turn on") {
            return .turnOn
        }
        if let _ = scanString("turn off") {
            return .turnOff
        }
        if let _ = scanString("toggle") {
            return .toggle
        }
        return nil
    }

    func scanOffsetRange() -> OffsetRange? {
        guard let start = scanOffset(),
              let _ = scanString("through"),
              let end = scanOffset() else {
            return nil
        }
        return OffsetRange(southWest: start, northEast: end)
    }

    func scanOffset() -> Offset? {
        guard let east = scanInt(),
              let _ = scanString(","),
              let north = scanInt() else {
            return nil
        }
        return Offset(east: east, north: north)
    }
}

public extension LightGrid.Instruction {
    init?(_ description: String) {
        let scanner = Scanner(string: description)
        guard let instruction = scanner.scanInstruction() else {
            return nil
        }
        self = instruction
    }
}

fileprivate let input = Bundle.module.text(named: "day6")

public func day6_1() -> Int {
    LightGrid(input).evaluate().count
}

public func day6_2() -> Int {
    0
}
