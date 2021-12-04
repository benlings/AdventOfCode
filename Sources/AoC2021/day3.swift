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

extension Array where Element == [Bit] {

    func totals() -> [Int] {
        columnIndices.map { i in
            total(at: i)
        }
    }
    func total(at index: Element.Index) -> Int {
        column(index).count(of: .on)
    }
}

public struct SubmarineDiagnostic {
    var bits: [[Bit]]

    func totals() -> [Int] {
        bits.totals()
    }

    public func gammaRate() -> Int {
        let count = bits.count
        return totals().map { Bit($0 > count / 2) }.toInt()
    }

    public func epsilonRate() -> Int {
        let count = bits.count
        return totals().map { Bit($0 <= count / 2) }.toInt()
    }

    public func powerConsumption() -> Int {
        gammaRate() * epsilonRate()
    }

    func filterNumbers(where filter: (_ ones: Int, _ zeroes: Int) -> Bool) -> [[Bit]] {
        var i = 0
        var remaining = bits
        while i < bits.first!.count && remaining.count > 1 {
            let ones = remaining.total(at: i)
            let zeros = remaining.count - ones
            let keep = Bit(filter(ones, zeros))
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
