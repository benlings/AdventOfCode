import XCTest
@testable import AoC2020

final class Day7Tests: XCTestCase {

    func testParseLuggageRuleMultipleBags() {
        let input = "light red bags contain 1 bright white bag, 2 muted yellow bags."
        let expected = LuggageRule(bag: LuggageBag(bagDescription: "light red"),
                                   contents: [
                                    LuggageBag(bagDescription: "bright white"),
                                    LuggageBag(bagDescription: "muted yellow")
                                   ])
        XCTAssertEqual(expected, LuggageRule(input))
    }

    func testParseLuggageRuleSingleBags() {
        let input = "bright white bags contain 1 shiny gold bag."
        let expected = LuggageRule(bag: LuggageBag(bagDescription: "bright white"),
                                   contents: [
                                    LuggageBag(bagDescription: "shiny gold"),
                                   ])
        XCTAssertEqual(expected, LuggageRule(input))
    }

    func testParseLuggageRuleNoBags() {
        let input = "faded blue bags contain no other bags."
        let expected = LuggageRule(bag: LuggageBag(bagDescription: "faded blue"),
                                   contents: [])
        XCTAssertEqual(expected, LuggageRule(input))
    }

    func testBagsThatContain() {
        let input = """
        light red bags contain 1 bright white bag, 2 muted yellow bags.
        dark orange bags contain 3 bright white bags, 4 muted yellow bags.
        bright white bags contain 1 shiny gold bag.
        muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
        shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
        dark olive bags contain 3 faded blue bags, 4 dotted black bags.
        vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
        faded blue bags contain no other bags.
        dotted black bags contain no other bags.
        """
        let processor = LuggageProcessor(rulesDescription: input)
        let expectedBags = ["bright white", "muted yellow", "dark orange", "light red"] as Set<LuggageBag>
        XCTAssertEqual(expectedBags, processor.bags(thatCanContain: "shiny gold"))
    }

    func testPart1() {
        XCTAssertEqual(day7_1(), 252)
    }

    func testPart2() {
//        XCTAssertEqual(day7_2(), 0)
    }
}

//
