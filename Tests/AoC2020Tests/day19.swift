import XCTest
import AoC2020

final class Day19Tests: XCTestCase {

    func testPart1Example1() {
        let input = """
        0: 1 2
        1: "a"
        2: 1 3 | 3 1
        3: "b"
        """
        let rules = MessageRules(input)
        XCTAssertEqual(rules.rules, [
            0: .consecutive([1, 2]),
            1: .character("a"),
            2: .alternative(.consecutive([1, 3]), .consecutive([3, 1])),
            3: .character("b"),
        ])
    }

    func testPart1() {
        XCTAssertEqual(day19_1(), 0)
    }

    func testPart2() {
        XCTAssertEqual(day19_2(), 0)
    }
}