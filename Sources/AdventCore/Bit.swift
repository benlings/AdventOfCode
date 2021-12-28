import Foundation

public extension Array where Element == Bit {
    func toInt<B : BinaryInteger>() -> B {
        reduce(0 as B) { $0 * 2 + $1.toInt() }
    }

   init(hex: String) {
        self = hex.flatMap { c -> [Bit] in
            let s = String(c.hexDigitValue!, radix: 2)
            let p = (repeatElement("0", count: 4 - s.count) + s)
            return p.compactMap(Bit.init(rawValue:))
        }
    }
}

public enum Bit : Character {
    case on = "1"
    case off = "0"
}

public extension Bool {
    init(_ bit: Bit) {
        self = bit == .on
    }
}

public extension Bit {

    func toggled() -> Bit {
        switch self {
        case .on: return .off
        case .off: return .on
        }
    }

    init(_ bool: Bool) {
        self = bool ? .on : .off
    }

    func toInt<I : ExpressibleByIntegerLiteral>() -> I {
        switch self {
        case .on: return 1
        case .off: return 0
        }
    }
}
