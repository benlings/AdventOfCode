import XCTest
import AoC2022

final class Day1Tests: XCTestCase {

    let input = Bundle.module.text(named: "day1")

    let exampleInput = """
    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000
    """

    func testPart1Example() {
        XCTAssertEqual(day1_1(exampleInput), 24000)
    }

    func testPart1() {
        XCTAssertEqual(day1_1(input), 71780)
    }

    func testPart2Example() {
        XCTAssertEqual(day1_2(exampleInput), 45000)
    }

    func testPart2() {
        XCTAssertEqual(day1_2(input), 212489)
    }
}
