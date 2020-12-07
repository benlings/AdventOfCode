import XCTest
@testable import AoC2020

final class Day7Tests: XCTestCase {

    func testParseLuggageRule() {
        let input = "light red bags contain 1 bright white bag, 2 muted yellow bags."
        let expected = LuggageRule(bag: LuggageBag(bagDescription: "light red"),
                                   contents: [
                                    LuggageBag(bagDescription: "bright white"),
                                    LuggageBag(bagDescription: "muted yellow")
                                   ])
        XCTAssertEqual(expected, LuggageRule(input))
    }

    func testPart1() {
//        XCTAssertEqual(day7_1(), 0)
    }

    func testPart2() {
//        XCTAssertEqual(day7_2(), 0)
    }
}

//
