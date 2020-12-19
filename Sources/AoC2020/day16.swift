import Foundation
import AdventCore

extension String {
    func commaSeparatedInts() -> [Int] {
        self.commaSeparated().ints()
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
        return nearbyTickets.flatMap {
            $0.toIndexSet().subtracting(validValues)
        }
    }

    public func validTickets() -> [[Int]] {
        let validValues = self.validValues
        return nearbyTickets.filter {
            $0.allSatisfy(validValues.contains)
        }
    }

    public func errorRate() -> Int {
        invalidNearbyTickets().sum()
    }

    public func inferredFieldOrder() -> [String] {
        let validTickets = self.validTickets()
        var used = Set<String>()
        return (0..<rules.count)
            // Get values for each ticket
            .map { fieldIndex in
                validTickets.map { $0[fieldIndex] }
            }
            // Find rules that are satisfied for each field
            .map { fieldValues in
                rules.filter { (_, ruleValues) -> Bool in
                    fieldValues.allSatisfy(ruleValues.contains)
                }.keys
            }
            // Keep track of index for later
            .enumerated()
            // Sort by how many rules are satisfied for each field
            .sorted(on: \.element.count)
            // Go through each in turn, eliminating fields we've placed
            .reduce(into: [(offset: Int, element: String)]()) { fields, e in
                let field = Set(e.element).subtracting(used).first!
                fields.append((e.offset, field))
                used.insert(field)
            }
            // Put back into index order
            .sorted(on: \.offset).map(\.element)
    }

    public func yourTicketFields() -> [String: Int] {
        zip(inferredFieldOrder(), yourTicket).toDictionary()
    }

    public func departureFieldProduct() -> Int {
        yourTicketFields().filter { (k, v) in
            k.starts(with: "departure")
        }.map(\.value).product()
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
    TicketTranslation(input).departureFieldProduct()
}
