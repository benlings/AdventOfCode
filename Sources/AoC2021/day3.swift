import Foundation
import AdventCore

public func toInt(binary: [Int]) -> Int {
    binary.reduce(0) { $0 * 2 + $1 }
}

extension Array where Element == [Int] {

    func totals() -> [Int] {
        columnIndices.map { i in
            total(at: i)
        }
    }
    func total(at index: Element.Index) -> Int {
        column(index).sum()
    }
}

public struct SubmarineDiagnostic {
    var numbers: [[Int]]

    func totals() -> [Int] {
        numbers.totals()
    }

    public func gammaRate() -> [Int] {
        let count = numbers.count
        return totals().map { $0 > count / 2 ? 1 : 0 }
    }

    public func epsilonRate() -> [Int] {
        let count = numbers.count
        return totals().map { $0 <= count / 2 ? 1 : 0 }
    }

    public func powerConsumption() -> Int {
        toInt(binary: gammaRate()) * toInt(binary: epsilonRate())
    }

    func filterNumbers(where filter: (_ ones: Int, _ zeroes: Int) -> Bool) -> [[Int]] {
        var i = 0
        var remaining = numbers
        while i < numbers.first!.count && remaining.count > 1 {
            let t = remaining.total(at: i)
            let c = remaining.count
            let keep = filter(t, c - t) ? 1 : 0
            remaining.removeAll { $0[i] != keep }
            i += 1
        }
        return remaining
    }

    public func oxygenGeneratorRating() -> [Int] {
        let remaining = filterNumbers(where: >=)
        assert(remaining.count == 1)
        return remaining.first!
    }

    public func co2ScrubberRating() -> [Int] {
        let remaining = filterNumbers(where: <)
        assert(remaining.count == 1)
        return remaining.first!
    }

    public func lifeSupportRating() -> Int {
        toInt(binary: oxygenGeneratorRating()) * toInt(binary: co2ScrubberRating())
    }
}

public extension SubmarineDiagnostic {
    init(_ report: String) {
        self.numbers = report.lines().map { $0.toArray().compactMap { $0.wholeNumberValue } }
    }
}


fileprivate let day3_input = Bundle.module.text(named: "day3")

public func day3_1() -> Int {
    SubmarineDiagnostic(day3_input).powerConsumption()
}

public func day3_2() -> Int {
    SubmarineDiagnostic(day3_input).lifeSupportRating()
}
