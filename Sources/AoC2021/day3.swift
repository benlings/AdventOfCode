import Foundation
import AdventCore

public extension Array where Element == Bit {
    func toInt() -> Int {
        reduce(0) { $0 * 2 + $1.toInt() }
    }
}

public enum Bit {
    case on
    case off
}

extension Bit {

    init(_ bool: Bool) {
        self = bool ? .on : .off
    }

    init?(_ character: Character) {
        switch character {
        case "1": self = .on
        case "0": self = .off
        default: return nil
        }
    }

    func toInt() -> Int {
        switch self {
        case .on: return 1
        case .off: return 0
        }
    }
}

public struct SubmarineDiagnostic {
    var bits: [[Bit]]

    func filterColumns(where filter: (_ ones: Int, _ zeroes: Int) -> Bool) -> [Bit] {
        let count = bits.count
        return bits.columns().map { column -> Bit in
            let ones = column.count(of: .on)
            let zeroes = count - ones
            return Bit(filter(ones, zeroes))
        }
    }

    public func gammaRate() -> Int {
        // More ones than zeroes
        filterColumns(where: >=).toInt()
    }

    public func epsilonRate() -> Int {
        // Fewer ones than zeroes
        filterColumns(where: <).toInt()
    }

    public func powerConsumption() -> Int {
        gammaRate() * epsilonRate()
    }

    func filterNumbers(where filter: (_ ones: Int, _ zeroes: Int) -> Bool) -> [[Bit]] {
        var i = 0
        var remaining = bits
        while i < bits.columnCount && remaining.count > 1 {
            let ones = remaining.column(i).count(of: .on)
            let zeroes = remaining.count - ones
            let keep = Bit(filter(ones, zeroes))
            remaining.removeAll { $0[i] != keep }
            i += 1
        }
        return remaining
    }

    public func oxygenGeneratorRating() -> Int {
        let remaining = filterNumbers(where: >=)
        assert(remaining.count == 1)
        return remaining.first!.toInt()
    }

    public func co2ScrubberRating() -> Int {
        let remaining = filterNumbers(where: <)
        assert(remaining.count == 1)
        return remaining.first!.toInt()
    }

    public func lifeSupportRating() -> Int {
        oxygenGeneratorRating() * co2ScrubberRating()
    }
}

public extension SubmarineDiagnostic {
    init(_ report: String) {
        self.bits = report.lines().map { $0.compactMap(Bit.init) }
    }
}


fileprivate let day3_input = Bundle.module.text(named: "day3")

public func day3_1() -> Int {
    SubmarineDiagnostic(day3_input).powerConsumption()
}

public func day3_2() -> Int {
    SubmarineDiagnostic(day3_input).lifeSupportRating()
}
