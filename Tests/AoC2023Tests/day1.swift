import XCTest
import AoC2023

final class Day1Tests: XCTestCase {

    let input = Bundle.module.text(named: "day1")

    let exampleInput = """
    """

    func testPart1Example() {
        XCTAssertEqual(day1_1(exampleInput), 0)
    }

    func testPart1() {
        XCTAssertEqual(day1_1(input), 0)
    }

    func testPart2Example() {
        XCTAssertEqual(day1_2(exampleInput), 0)
    }

    func testPart2() {
        XCTAssertEqual(day1_2(input), 0)
    }
}