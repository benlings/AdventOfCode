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
    var x: Int = 1
    var screen = Grid(repeating: Bit.off, size: Offset(east: 40, north: 6))

    mutating func execute(instructions: some Sequence<Instruction>) -> Int {
        var inspection = [20, 60, 100, 140, 180, 220] as Deque<Int>
        var sumSigStrength = 0
        var cycle = 1
        for instruction in instructions {

            guard let nextInspection = inspection.first else {
                break
            }
            if (cycle..<(cycle + instruction.cycles)).contains(nextInspection) {
                inspection.removeFirst()
                sumSigStrength += nextInspection * x
            }

            switch instruction {
            case .addx(let v): x += v
            case .noop: ()
            }

            cycle += instruction.cycles
        }
        return sumSigStrength
    }

    mutating func execute2(instructions: some Sequence<Instruction>) {
        var cycle = 1
        for instruction in instructions {

            for _ in 0..<instruction.cycles {
                let column = (cycle - 1) % screen.size.east
                let row = (cycle - 1) / screen.size.east
                let pos = Offset(east: column, north: row)

                if ((x - 1)...(x + 1)).contains(column) {
                    screen[pos] = .on
                }

                cycle += 1
            }

            switch instruction {
            case .addx(var v): x += v
            case .noop: ()
            }
        }
    }
}

public func sumSignalStrengths(_ lines: some Sequence<String>) -> Int {
    var cpu = CPU()
    return cpu.execute(instructions: lines.compactMap(Instruction.init))
}

public func getScreenContents(_ lines: some Sequence<String>) -> String {
    var cpu = CPU()
    cpu.execute2(instructions: lines.compactMap(Instruction.init))
    return cpu.screen.description
}

fileprivate let day10_input = Bundle.module.text(named: "day10").lines()

public func day10_1() -> Int {
    sumSignalStrengths(day10_input)
}

public func day10_2() -> Int {
    print(getScreenContents(day10_input))
    return 0
}
