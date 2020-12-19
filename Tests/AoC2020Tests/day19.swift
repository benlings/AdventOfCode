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
        XCTAssertEqual(rules.match("aab"), true)
        XCTAssertEqual(rules.match("aba"), true)
        XCTAssertEqual(rules.match("baa"), false)
        XCTAssertEqual(rules.match("aaba"), false)
    }

    func testPart1Example2() {
        let input = """
        0: 4 1 5
        1: 2 3 | 3 2
        2: 4 4 | 5 5
        3: 4 5 | 5 4
        4: "a"
        5: "b"
        """
        let rules = MessageRules(input)
        XCTAssertEqual(rules.match("aaaabb"), true)
        XCTAssertEqual(rules.match("aaabab"), true)
        XCTAssertEqual(rules.match("abbabb"), true)
        XCTAssertEqual(rules.match("abbbab"), true)
        XCTAssertEqual(rules.match("aabaab"), true)
        XCTAssertEqual(rules.match("aabbbb"), true)
        XCTAssertEqual(rules.match("abaaab"), true)
        XCTAssertEqual(rules.match("ababbb"), true)
        XCTAssertEqual(rules.match("ababba"), false)
        XCTAssertEqual(rules.match("bbabba"), false)
        XCTAssertEqual(rules.match("aaabbb"), false)
    }

    func testPart1() {
        XCTAssertEqual(day19_1(), 0)
    }

    func testPart2() {
        XCTAssertEqual(day19_2(), 0)
    }
}