import Foundation
import AdventCore
import Algorithms

extension CharacterSet {
    static let maskCharacters = CharacterSet(charactersIn: "X10")
}

extension UInt64 {
    func bitPermutations(mask: UInt64) -> AnySequence<UInt64> {
        if mask == 0 {
            return AnySequence([self])
        } else {
            let setBit = 0b1 << mask.trailingZeroBitCount as UInt64
            return AnySequence(chain((self | setBit).bitPermutations(mask: mask & ~setBit),
                         (self & ~setBit).bitPermutations(mask: mask & ~setBit)))
        }
    }
}

enum Instruction {
    case mask(setting: UInt64, unsetting: UInt64)
    case mem(location: UInt64, newValue: UInt64)


    static func parse(_ input: String) -> Instruction? {
        let scanner = Scanner(string: input)
        if scanner.scanString("mask") != nil,
           scanner.scanString("=") != nil,
           let maskValue = scanner.scanCharacters(from: .maskCharacters),
           let setting = UInt64(maskValue.replacingOccurrences(of: "X", with: "0"), radix: 2),
           let unsetting = UInt64(maskValue.replacingOccurrences(of: "X", with: "1"), radix: 2) {
            return .mask(setting: setting, unsetting: unsetting)
        }
        if scanner.scanString("mem[") != nil,
           let location = scanner.scanUInt64(),
           scanner.scanString("]") != nil,
           scanner.scanString("=") != nil,
           let value = scanner.scanUInt64() {
            return .mem(location: location, newValue: value)
        }
        return nil
    }

    func eval(context: inout MemContext) {
        switch self {
        case .mask(let setting, let unsetting):
            context.maskSettingBits = setting
            context.maskUnsettingBits = unsetting
        case .mem(let location, let newValue):
            switch context.mode {
            case .v1:
                context.memory[location] = (newValue | context.maskSettingBits) & context.maskUnsettingBits
            case .v2:
                let maskedLocation = location | context.maskSettingBits
                let floatingMask = context.maskUnsettingBits & ~context.maskSettingBits
                for floatingLocation in maskedLocation.bitPermutations(mask: floatingMask) {
                    context.memory[floatingLocation] = newValue
                }
            }
        }
    }
}

public struct MemInstructions {

    public enum Mode { case v1, v2 }

    var instructions: [Instruction]

    public func execute(mode: Mode = .v1) -> UInt64 {
        var context = MemContext(mode: mode)
        eval(&context)
        return context.memory.values.sum()
    }

    public func eval(_ context: inout MemContext) {
        instructions.forEach { $0.eval(context: &context) }
    }
}

public extension MemInstructions {
    init(_ input: String) {
        self = .init(instructions: input.lines().compactMap(Instruction.parse))
    }
}

public struct MemContext {
    var mode: MemInstructions.Mode
    var maskSettingBits: UInt64 = 0
    var maskUnsettingBits: UInt64 = 0
    var memory: [UInt64: UInt64] = [:]
}

fileprivate let input = Bundle.module.text(named: "day14")

public func day14_1() -> Int {
    Int(MemInstructions(input).execute())
}

public func day14_2() -> Int {
    0
}
