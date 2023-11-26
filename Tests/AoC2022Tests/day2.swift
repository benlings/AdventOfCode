import XCTest
import AoC2022

final class Day2Tests: XCTestCase {

    let input = Bundle.module.text(named: "day2").lines()

    let exampleInput = """
    A Y
    B X
    C Z
    """.lines()

    func testPart1Example() {
        XCTAssertEqual(day2_1(exampleInput), 15)
    }

    func testPart1() {
        XCTAssertEqual(day2_1(input), 10404)
    }

    func testPart2Example() {
        XCTAssertEqual(day2_2(exampleInput), 12)
    }

    func testPart2() {
        XCTAssertEqual(day2_2(input), 10334)
    }
}
