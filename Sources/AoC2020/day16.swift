import Foundation
import AdventCore

extension String {
    func toIndexSet() -> IndexSet {
        self.components(separatedBy: ",")
            .ints()
            .reduce(IndexSet()) {
                $0.union(IndexSet(integer: $1))
            }
    }
}

public struct TicketTranslation {
    var rules: [String: IndexSet]
    var yourTicket: IndexSet
    var nearbyTickets: [IndexSet]

    var validValues: IndexSet {
        rules.values.reduce(IndexSet()) { $0.union($1) }
    }

    public func invalidNearbyTickets() -> [Int] {
        let validValues = self.validValues
        var result = [Int]()
        for t in nearbyTickets {
            result.append(contentsOf: t.subtracting(validValues))
        }
        return result
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
        yourTicket = yourTicketDescription.toIndexSet()
        nearbyTickets = groups[2].lines().dropFirst().map {
            $0.toIndexSet()
        }
    }
}

public func day16_1() -> Int {
    0
}

public func day16_2() -> Int {
    0
}
