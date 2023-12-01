import XCTest
import AoC2023

final class Day1Tests: XCTestCase {

    let input = Bundle.module.text(named: "day1")

    let exampleInput = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """

    func testPart1Example() {
        XCTAssertEqual(day1_1(exampleInput), 142)
    }

    func testPart1() {
        XCTAssertEqual(day1_1(input), 55488)
    }

    let exampleInput2 = """
    two1nine
    eightwothree
    abcone2threexyz
    xtwone3four
    4nineeightseven2
    zoneight234
    7pqrstsixteen
    """

    func testPart2Example() {
        XCTAssertEqual(day1_2(exampleInput2), 281)
    }

    func testPart2() {
        XCTAssertEqual(day1_2(input), 55614)
    }
}
