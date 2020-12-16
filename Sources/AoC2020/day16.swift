import Foundation
import AdventCore

extension String {
    func commaSeparatedInts() -> [Int] {
        self.commaSeparated().ints()
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
        return nearbyTickets.flatMap {
            $0.toIndexSet().subtracting(validValues)
        }
    }

    public func validTickets() -> [[Int]] {
        let validValues = self.validValues
        return nearbyTickets.filter {
            $0.allSatisfy { validValues.contains($0) }
        }
    }

    public func errorRate() -> Int {
        invalidNearbyTickets().sum()
    }

    public func inferredFieldOrder() -> [String] {
        let possible = (0..<rules.count)
            .map { i in
                validTickets().map { $0[i] }
            }
            .map { fieldValues in
                rules.filter { (key, ruleValues) -> Bool in
                    fieldValues.allSatisfy { ruleValues.contains($0) }
                }
            }.enumerated().sorted(on: \.element.count)
        var r = [(Int, String)]()
        var used = Set<String>()
        for e in possible {
            let field = Set(e.element.keys).subtracting(used).first!
            r.append((e.offset, field))
            used.insert(field)
        }
        return r.sorted(on: \.0).map(\.1)
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
