import Foundation
import AdventCore

public struct Circuit {
    public typealias WireId = String
    public typealias Signal = UInt16

    enum WireInput {
        case signal(Signal)
        case id(WireId)
    }

    enum Connection {
        case and(WireInput, WireInput)
        case or(WireInput, WireInput)
        case lshift(WireInput, Int)
        case rshift(WireInput, Int)
        case not(WireInput)
        case passthrough(WireInput)
    }

    typealias WireConfiguration = [WireId : Connection]

    var configuration: WireConfiguration

    mutating func signal(input: WireInput) -> Signal {
        switch input {
        case .signal(let s): return s
        case .id(let id): return signal(id: id)
        }
    }

    mutating func signal(connection: Connection) -> Signal {
        switch connection {
        case .and(let lhs, let rhs): return signal(input: lhs) & signal(input: rhs)
        case .or(let lhs, let rhs): return signal(input: lhs) | signal(input: rhs)
        case .lshift(let lhs, let rhs): return signal(input: lhs) << rhs
        case .rshift(let lhs, let rhs): return signal(input: lhs) >> rhs
        case .not(let arg): return ~signal(input: arg)
        case .passthrough(let arg): return signal(input: arg)
        }
    }

    public mutating func signal(id: WireId) -> Signal {
        guard let connection = configuration[id] else {
            preconditionFailure()
        }
        let s = signal(connection: connection)
        configuration[id] = .passthrough(.signal(s))
        return s
    }
}

extension Scanner {
    func scanWireConfig() -> (Circuit.WireId, Circuit.Connection)? {
        guard let connection = scanWireConnection(),
              let _ = scanString("->"),
              let id = scanWireId() else {
            return nil
        }
        return (id, connection)
    }

    func scanWireId() -> Circuit.WireId? {
        scanUpToCharacters(from: .whitespacesAndNewlines)
    }

    func scanWireInput() -> Circuit.WireInput? {
        if let i = scanInt(),
           let s = UInt16(exactly: i) {
            return .signal(s)
        }
        if let id = scanWireId() {
            return .id(id)
        }
        return nil
    }

    func scanWireConnection() -> Circuit.Connection? {
        if scanString("NOT") != nil,
           let input = scanWireInput() {
            return .not(input)
        }
        if let lhs = scanWireInput() {
            if peekString("->") {
                return .passthrough(lhs)
            }
            switch scanUpToCharacters(from: .whitespaces) {
            case "AND":
                return scanWireInput().map { .and(lhs, $0) }
            case "OR":
                return scanWireInput().map { .or(lhs, $0) }
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
            .map {
                Scanner(string: $0).scanWireConfig()!
            }
            .toDictionary()
    }
}

fileprivate let input = Bundle.module.text(named: "day7")

public func day7_1() -> UInt16 {
    var circuit = Circuit(input)
    return circuit.signal(id: "a")
}

public func day7_2() -> Int {
    0
}
