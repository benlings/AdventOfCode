import XCTest
import AoC2022

final class Day4Tests: XCTestCase {

    let input = Bundle.module.text(named: "day4").lines()

    let exampleInput = """
    2-4,6-8
    2-3,4-5
    5-7,7-9
    2-8,3-7
    6-6,4-6
    2-6,4-8
    """.lines()

    func testPart1Example() {
        XCTAssertEqual(day4_1(exampleInput), 2)
    }

    func testPart1() {
        XCTAssertEqual(day4_1(input), 562)
    }

    func testPart2Example() {
        XCTAssertEqual(day4_2(exampleInput), 4)
    }

    func testPart2() {
        XCTAssertEqual(day4_2(input), 924)
    }
}
