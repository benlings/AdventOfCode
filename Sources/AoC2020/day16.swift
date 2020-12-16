import Foundation
import AdventCore

extension String {
    func commaSeparatedInts() -> [Int] {
        self.components(separatedBy: ",")
            .ints()
    }
}

extension Sequence where Element == Int {
    func toIndexSet() -> IndexSet {
        self.reduce(IndexSet()) {
            $0.union(IndexSet(integer: $1))
        }
    }
}

public struct TicketTranslation {
    var rules: [String: IndexSet]
    var yourTicket: [Int]
    var nearbyTickets: [[Int]]

    var validValues: IndexSet {
        rules.values.reduce(IndexSet()) { $0.union($1) }
    }

    public func invalidNearbyTickets() -> [Int] {
        let validValues = self.validValues
        var result = [Int]()
        for t in nearbyTickets {
            result.append(contentsOf: t.toIndexSet().subtracting(validValues))
        }
        return result
    }

    public func errorRate() -> Int {
        invalidNearbyTickets().sum()
    }
}

public extension TicketTranslation {
    init(_ description: String) {
        let groups = description.groups()
        let ruleDescriptions = groups[0].lines()
        rules = ruleDescriptions.compactMap { d -> (String, IndexSet)? in
            let scanner = Scanner(string: d)
            guard let fieldName = scanner.scanUpToString(":") else {
                return nil
            }
            _ = scanner.scanString(":")
            var ranges = IndexSet()
            while !scanner.isAtEnd {
                let start = scanner.scanInt()!
                _ = scanner.scanString("-")
                let end = scanner.scanInt()!
                _ = scanner.scanString("or")
                ranges.insert(integersIn: start...end)
            }
            return (fieldName, ranges)
        }.toDictionary()
        let yourTicketDescription = groups[1].lines()[1]
        yourTicket = yourTicketDescription.commaSeparatedInts()
        nearbyTickets = groups[2].lines().dropFirst().map {
            $0.commaSeparatedInts()
        }
    }
}

fileprivate let input = Bundle.module.text(named: "day16")

public func day16_1() -> Int {
    TicketTranslation(input).errorRate()
}

public func day16_2() -> Int {
    0
}
