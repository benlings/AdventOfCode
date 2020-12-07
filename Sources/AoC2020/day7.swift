import Foundation
import AdventCore

public struct LuggageBag : Hashable, Equatable {
    var bagDescription: String
}

extension LuggageBag : ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self = .init(bagDescription: value)
    }
}

public struct LuggageRule : Equatable {
    var bag: LuggageBag
    var contents = Set<LuggageBag>() // FIXME add count

    func transitiveContents(rules: [LuggageRule]) -> Set<LuggageBag> {
        contents.union(rules.filter { contents.contains($0.bag) }.flatMap { $0.transitiveContents(rules: rules) })
    }
}

extension Scanner {
    func scanLuggageBag() -> LuggageBag? {
        guard let description1 = scanUpToCharacters(from: .whitespaces),
              let description2 = scanUpToCharacters(from: .whitespaces),
              scanString("bags") ?? scanString("bag") != nil else {
            return nil
        }
        return LuggageBag(bagDescription: "\(description1) \(description2)")
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
            _ = scanner.scanInt() // Count
            contents.insert(scanner.scanLuggageBag()!)
            _ = scanner.scanString(",") ?? scanner.scanString(".")
        }
    }
}

public struct LuggageProcessor {
    var rules: [LuggageRule]

    public func bags(thatCanContain bag: LuggageBag) -> Set<LuggageBag> {
        var containingBags = Set<LuggageBag>()
        for rule in rules {
            if rule.transitiveContents(rules: rules).contains(bag) {
                containingBags.insert(rule.bag)
            }
        }
        return containingBags
    }
}

extension LuggageProcessor {
    public init(rulesDescription: String) {
        self = .init(rules: rulesDescription.lines().compactMap(LuggageRule.init))
    }
}

fileprivate let day5_input = Bundle.module.text(named: "day7")

func day7_1() -> Int {
    LuggageProcessor(rulesDescription: day5_input).bags(thatCanContain: "shiny gold").count
}
