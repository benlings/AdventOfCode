import Foundation
import AdventCore

public struct Bag : Hashable, Equatable, CustomStringConvertible {
    public var description: String
}

extension Bag : ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self = .init(description: value)
    }
}

public struct LuggageRule : Equatable {
    var bag: Bag
    var contents = Dictionary<Bag, Int>()
}

extension Scanner {
    func scanLuggageBag() -> Bag? {
        guard let description1 = scanUpToCharacters(from: .whitespaces),
              let description2 = scanUpToCharacters(from: .whitespaces),
              scanString("bags") ?? scanString("bag") != nil else {
            return nil
        }
        return Bag(description: "\(description1) \(description2)")
    }
}

public extension LuggageRule {
    init?(_ ruleDescription: String) {
        let scanner = Scanner(string: ruleDescription)
        self.bag = scanner.scanLuggageBag()!
        _ = scanner.scanString("contain")
        while !scanner.isAtEnd {
            if scanner.scanString("no other bags") != nil {
                break
            }
            let count = scanner.scanInt() // Count
            contents[scanner.scanLuggageBag()!] = count
            _ = scanner.scanString(",") ?? scanner.scanString(".")
        }
    }
}

public struct LuggageProcessor {
    var rules: [LuggageRule]

    func containingBags() -> Dictionary<Bag, Set<Bag>> {
        var result = Dictionary<Bag, Set<Bag>>()
        for rule in rules {
            for containedBag in rule.contents.keys {
                result[containedBag, default: Set()].insert(rule.bag)
            }
        }
        return result
    }

    public func bags(thatCanContain bag: Bag) -> Set<Bag> {
        let inverted = self.containingBags()
        var result = Set<Bag>()
        func addContainingBags(_ containedBag: Bag) {
            guard let containingBags = inverted[containedBag] else {
                return
            }
            result.formUnion(containingBags)
            for bag in containingBags {
                addContainingBags(bag)
            }
        }
        addContainingBags(bag)
        return result
    }

    public func countOfBags(containedWithin bag: Bag) -> Int {
        let lookup = Dictionary(uniqueKeysWithValues: rules.map { ($0.bag, $0) })
        func containedBags(_ containingBag: Bag) -> Int {
            guard let rule = lookup[containingBag] else {
                fatalError("\(containingBag) not in lookup")
            }
            var result = 1
            for (bag, count) in rule.contents {
                result += count * containedBags(bag)
            }
            return result
        }
        return containedBags(bag) - 1
    }
}

extension LuggageProcessor {
    public init(rulesDescription: String) {
        self = .init(rules: rulesDescription.lines().compactMap(LuggageRule.init))
    }
}

fileprivate let day7_input = Bundle.module.text(named: "day7")

func day7_1() -> Int {
    LuggageProcessor(rulesDescription: day7_input).bags(thatCanContain: "shiny gold").count
}

func day7_2() -> Int {
    LuggageProcessor(rulesDescription: day7_input).countOfBags(containedWithin: "shiny gold")
}
