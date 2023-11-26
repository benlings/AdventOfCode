import XCTest
import AoC2022

final class Day14Tests: XCTestCase {

    let input = Bundle.module.text(named: "day14").lines()

    let exampleInput = """
    498,4 -> 498,6 -> 496,6
    503,4 -> 502,4 -> 502,9 -> 494,9
    """.lines()

    func testPart1Example() {
        XCTAssertEqual(day14_1(exampleInput), 24)
    }

    func testPart1() {
        XCTAssertEqual(day14_1(input), 825)
    }

    func testPart2Example() {
        XCTAssertEqual(day14_2(exampleInput), 93)
    }

    func testPart2() {
        XCTAssertEqual(day14_2(input), 26729)
    }
}
