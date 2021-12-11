import Foundation
import AdventCore

public extension Array where Element == Bit {
    func toInt() -> Int {
        reduce(0) { $0 * 2 + $1.toInt() }
    }
}

public enum Bit : Character {
    case on = "1"
    case off = "0"
}

extension Bit {

    init(_ bool: Bool) {
        self = bool ? .on : .off
    }

    func toInt() -> Int {
        switch self {
        case .on: return 1
        case .off: return 0
        }
    }
}

public struct SubmarineDiagnostic {
    var bits: Grid<Bit>

    func filterColumns(where filter: (_ ones: Int, _ zeroes: Int) -> Bool) -> [Bit] {
        return bits.columns().map { column -> Bit in
            let ones = column.count(of: .on)
            let zeroes = column.count - ones
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
        var remaining = bits.rows()
        for i in bits.columnIndices {
            guard remaining.count > 1 else { break }
            let column = remaining.column(i)
            let ones = column.count(of: .on)
            let zeroes = column.count - ones
            let keep = Bit(filter(ones, zeroes))
            remaining.removeAll { $0[i] != keep }
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
        self.bits = Grid(lines: report.lines())
    }
}


fileprivate let day3_input = Bundle.module.text(named: "day3")

public func day3_1() -> Int {
    SubmarineDiagnostic(day3_input).powerConsumption()
}

public func day3_2() -> Int {
    SubmarineDiagnostic(day3_input).lifeSupportRating()
}
