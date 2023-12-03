import XCTest
import AoC2023

final class Day3Tests: XCTestCase {

    let input = Bundle.module.text(named: "day3")

    let exampleInput = """
    """

    func testPart1Example() {
        XCTAssertEqual(day3_1(exampleInput), 0)
    }

    func testPart1() {
        XCTAssertEqual(day3_1(input), 0)
    }

    func testPart2Example() {
        XCTAssertEqual(day3_2(exampleInput), 0)
    }

    func testPart2() {
        XCTAssertEqual(day3_2(input), 0)
    }
}