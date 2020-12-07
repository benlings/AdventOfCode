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

    func containingBags() -> Dictionary<LuggageBag, Set<LuggageBag>> {
        var result = Dictionary<LuggageBag, Set<LuggageBag>>()
        for rule in rules {
            for containedBag in rule.contents {
                result[containedBag, default: Set()].insert(rule.bag)
            }
        }
        return result
    }

    public func bags(thatCanContain bag: LuggageBag) -> Set<LuggageBag> {
        let inverted = self.containingBags()
        var result = Set<LuggageBag>()
        func addContainingBags(_ containedBag: LuggageBag) {
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
