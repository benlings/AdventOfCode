import Foundation
import AdventCore

public struct Polymerization {

    // WORKAROUND: SE-0283
    struct Pair : Hashable {
        var first: Character
        var second: Character
    }

    var templateCount: [Pair: Int]
    var last: Character
    var insertionRules: [Pair: Character]

    public mutating func step() {
        templateCount = templateCount.flatMap { pair, count -> [(Pair, Int)] in
            if let match = insertionRules[pair] {
                return [(Pair(first: pair.first, second: match), count),
                        (Pair(first: match, second: pair.second), count)]
            } else {
                return [(pair, count)]
            }
        }.toDictionarySummingValues()
    }

    public mutating func step(count: Int) {
        for _ in 0..<count {
            step()
        }
    }

    public func elementsDifference() -> Int {
        var counts = templateCount.map { ($0.key.first, $0.value) }.toDictionarySummingValues()
        counts[last, default: 0] += 1
        let minMax = counts.values.minAndMax()!
        return minMax.max - minMax.min
    }
}

fileprivate extension Scanner {
    func scanInsertionRule() -> (Polymerization.Pair, Character)? {
        guard let first = scanCharacter(),
              let second = scanCharacter(),
              let _ = scanString("->"),
              let insertion = scanCharacter() else {
                  return nil
              }
        return (Polymerization.Pair(first: first, second: second), insertion)
    }
}

extension Polymerization {
    public init(_ description: String) {
        let groups = description.groups()
        self.templateCount = groups[0].adjacentPairs().map { (Pair(first: $0.0, second: $0.1), 1) }.toDictionarySummingValues()
        self.last = groups[0].last!
        self.insertionRules = groups[1].lines().compactMap { line in
            Scanner(string: line).scanInsertionRule()
        }.toDictionary()
    }
}

fileprivate let day14_input = Bundle.module.text(named: "day14")

public func day14_1() -> Int {
    var poly = Polymerization(day14_input)
    poly.step(count: 10)
    return poly.elementsDifference()
}

public func day14_2() -> Int {
    var poly = Polymerization(day14_input)
    poly.step(count: 40)
    return poly.elementsDifference()
}
