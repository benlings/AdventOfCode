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
        guard let bag = scanner.scanLuggageBag() else {
            return nil
        }
        self.bag = bag
        _ = scanner.scanString("contain")
        while !scanner.isAtEnd {
            if scanner.scanString("no other bags") != nil {
                break
            }
            guard let count = scanner.scanInt(),
                  let contentsBag = scanner.scanLuggageBag() else {
                return nil
            }
            contents[contentsBag] = count
            _ = scanner.scanString(",") ?? scanner.scanString(".")
        }
    }
}

public struct LuggageProcessor {
    var rules: [LuggageRule]

    public func countOfBags(containing bag: Bag) -> Int {
        let bagContents = Dictionary(uniqueKeysWithValues: rules.map { ($0.bag, $0.contents) })
        func containsBag(_ containingBag: Bag, _ containedBag: Bag) -> Bool {
            guard let contents = bagContents[containingBag] else {
                fatalError("\(containingBag) not in lookup")
            }
            return contents.contains { (key, _) in
                key == containedBag || containsBag(key, containedBag)
            }
        }
        return rules.count { rule in
            containsBag(rule.bag, bag)
        }
    }

    public func countOfBags(containedWithin bag: Bag) -> Int {
        let bagContents = Dictionary(uniqueKeysWithValues: rules.map { ($0.bag, $0.contents) })
        func containedBags(_ containingBag: Bag) -> Int {
            guard let contents = bagContents[containingBag] else {
                fatalError("\(containingBag) not in lookup")
            }
            return contents.map { bag, count in
                count * (1 + containedBags(bag))
            }.sum()
        }
        return containedBags(bag)
    }
}

extension LuggageProcessor {
    public init(rulesDescription: String) {
        self = .init(rules: rulesDescription.lines().compactMap(LuggageRule.init))
    }
}

fileprivate let day7_input = Bundle.module.text(named: "day7")

func day7_1() -> Int {
    LuggageProcessor(rulesDescription: day7_input).countOfBags(containing: "shiny gold")
}

func day7_2() -> Int {
    LuggageProcessor(rulesDescription: day7_input).countOfBags(containedWithin: "shiny gold")
}
