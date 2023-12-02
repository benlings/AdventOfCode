import XCTest
import AoC2023

final class Day2Tests: XCTestCase {

    let input = Bundle.module.text(named: "day2")

    let exampleInput = """
    """

    func testPart1Example() {
        XCTAssertEqual(day2_1(exampleInput), 0)
    }

    func testPart1() {
        XCTAssertEqual(day2_1(input), 0)
    }

    func testPart2Example() {
        XCTAssertEqual(day2_2(exampleInput), 0)
    }

    func testPart2() {
        XCTAssertEqual(day2_2(input), 0)
    }
}