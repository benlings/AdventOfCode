import Foundation
import AdventCore

public struct Circuit {
    public typealias WireId = String
    public typealias Signal = UInt16

    enum WireInput {
        case signal(Signal)
        case and(WireId, WireId)
        case or(WireId, WireId)
        case lshift(WireId, Int)
        case rshift(WireId, Int)
        case not(WireId)
    }

    typealias WireConfiguration = [WireId : WireInput]

    var configuration: WireConfiguration

    public func signal(id: WireId) -> Signal {
        switch configuration[id] {
        case .signal(let s): return s
        case .and(let lhs, let rhs): return signal(id: lhs) & signal(id: rhs)
        case .or(let lhs, let rhs): return signal(id: lhs) | signal(id: rhs)
        case .lshift(let lhs, let rhs): return signal(id: lhs) << rhs
        case .rshift(let lhs, let rhs): return signal(id: lhs) >> rhs
        case .not(let arg): return ~signal(id: arg)
        default:
            preconditionFailure()
        }
    }
}

extension Scanner {
    func scanWireConfig() -> (Circuit.WireId, Circuit.WireInput)? {
        guard let input = scanWireInput(),
              let _ = scanString("->"),
              let id = scanWireId() else {
            return nil
        }
        return (id, input)
    }

    func scanWireId() -> Circuit.WireId? {
        scanUpToCharacters(from: .whitespacesAndNewlines)
    }

    func scanWireInput() -> Circuit.WireInput? {
        if let i = scanInt(),
           let s = UInt16(exactly: i) {
            return .signal(s)
        }
        if scanString("NOT") != nil,
           let id = scanWireId() {
            return .not(id)
        }
        if let lhs = scanWireId() {
            switch scanUpToCharacters(from: .whitespaces) {
            case "AND":
                return scanWireId().map { .and(lhs, $0) }
            case "OR":
                return scanWireId().map { .or(lhs, $0) }
            case "LSHIFT":
                return scanInt().map { .lshift(lhs, $0) }
            case "RSHIFT":
                return scanInt().map { .rshift(lhs, $0) }
            default:
                return nil
            }
        }
        return nil
    }


}

public extension Circuit {
    init(_ description: String) {
        configuration = description
            .lines()
            .compactMap {
                Scanner(string: $0).scanWireConfig()
            }
            .toDictionary()
    }
}

public func day7_1() -> Int {
    0
}

public func day7_2() -> Int {
    0
}
