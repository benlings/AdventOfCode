import Foundation
import AdventCore
import Collections

enum Instruction {
    case addx(Int)
    case noop

    var cycles: Int {
        switch self {
        case .addx: return 2
        case .noop: return 1
        }
    }
}

extension Instruction {
    init?(_ input: String) {
        let scanner = Scanner(string: input)
        switch scanner.scanUpToCharacters(from: .whitespaces) {
        case "addx":
            guard let v = scanner.scanInt() else { return nil }
            self = .addx(v)
        case "noop":
            self = .noop
        default:
            return nil
        }
    }
}

struct CPU {
    var cycle: Int = 1
    var x: Int = 1

    mutating func execute1(instructions: some Sequence<Instruction>) -> Int {
        let inspections = (20...220).striding(by: 40)
        var sumSigStrength = 0
        execute(instructions: instructions) { cpu in
            if inspections.contains(cpu.cycle) {
                sumSigStrength += cpu.cycle * cpu.x
            }
        }
        return sumSigStrength
    }

    mutating func execute2(instructions: some Sequence<Instruction>) -> Grid<Bit> {
        var screen = Grid(repeating: Bit.off, size: Offset(east: 40, north: 6))
        execute(instructions: instructions) { cpu in
            let (row, column) = (cpu.cycle - 1).quotientAndRemainder(dividingBy: screen.size.east)
            let pos = Offset(east: column, north: row)

            if ((cpu.x - 1)...(cpu.x + 1)).contains(column) {
                screen[pos] = .on
            }
        }
        return screen
    }

    mutating func execute(instructions: some Sequence<Instruction>, observer: (CPU) -> ()) {
        for instruction in instructions {

            for _ in 0..<instruction.cycles {
                observer(self)
                cycle += 1
            }

            switch instruction {
            case .addx(let v): x += v
            case .noop: ()
            }
        }
    }
}

public func sumSignalStrengths(_ lines: some Sequence<String>) -> Int {
    var cpu = CPU()
    return cpu.execute1(instructions: lines.compactMap(Instruction.init))
}

public func getScreenContents(_ lines: some Sequence<String>) -> String {
    var cpu = CPU()
    return cpu.execute2(instructions: lines.compactMap(Instruction.init)).description
}

public func day10_1(_ input: [String]) -> Int {
    sumSignalStrengths(input)
}

public func day10_2(_ input: [String]) -> String {
    getScreenContents(input)
}
