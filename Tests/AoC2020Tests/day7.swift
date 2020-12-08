import XCTest
@testable import AoC2020

final class Day7Tests: XCTestCase {

    func testParseLuggageRuleMultipleBags() {
        let input = "light red bags contain 1 bright white bag, 2 muted yellow bags."
        let expected = LuggageRule(bag: "light red",
                                   contents: [
                                    "bright white" : 1,
                                    "muted yellow" : 2
                                   ])
        XCTAssertEqual(expected, LuggageRule(input))
    }

    func testParseLuggageRuleSingleBags() {
        let input = "bright white bags contain 1 shiny gold bag."
        let expected = LuggageRule(bag: "bright white",
                                   contents: [
                                    "shiny gold" : 1,
                                   ])
        XCTAssertEqual(expected, LuggageRule(input))
    }

    func testParseLuggageRuleNoBags() {
        let input = "faded blue bags contain no other bags."
        let expected = LuggageRule(bag: "faded blue",
                                   contents: [:])
        XCTAssertEqual(expected, LuggageRule(input))
    }

    let exampleInput1 = """
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

    func testBagsThatContain() {
        let processor = LuggageProcessor(rulesDescription: exampleInput1)
        XCTAssertEqual(processor.countOfBags(containing: "shiny gold"), 4)
    }

    func testPart1() {
        XCTAssertEqual(day7_1(), 252)
    }

    func testCountOfContainedBags() {
        let processor = LuggageProcessor(rulesDescription: exampleInput1)
        XCTAssertEqual(processor.countOfBags(containedWithin: "shiny gold"), 32)
    }

    func testPart2() {
        XCTAssertEqual(day7_2(), 35487)
    }
}

//
