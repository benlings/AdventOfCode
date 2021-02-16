import XCTest
import AoC2015

final class Day8Tests: XCTestCase {

    func testPart1Example() {
        let input = #"""
        ""
        "abc"
        "aaa\"aaa"
        "\x27"
        """#
        XCTAssertEqual(Matchsticks(input).excessCharacters(), 12)
    }

    func testPart1() {
        XCTAssertEqual(day8_1(), 0)
    }

    func testPart2() {
        XCTAssertEqual(day8_2(), 0)
    }
}
