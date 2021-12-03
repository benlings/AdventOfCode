import Foundation
import AdventCore

public func toInt(binary: [Int]) -> Int {
    binary.reduce(0) { $0 * 2 + $1 }
}

public struct SubmarineDiagnostic {
    var numbers: [[Int]]

    func totals() -> [Int] {
        let indices = numbers.first!.indices
        return indices.map { i in
            numbers.map { $0[i] }.sum()
        }
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
    0
}
