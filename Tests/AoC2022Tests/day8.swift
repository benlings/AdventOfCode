import XCTest
import AoC2022

final class Day8Tests: XCTestCase {

    let input = Bundle.module.text(named: "day8")

    let exampleInput = """
    30373
    25512
    65332
    33549
    35390
    """

    func testPart1Example() {
        XCTAssertEqual(day8_1(exampleInput), 21)
    }

    func testPart1() {
        XCTAssertEqual(day8_1(input), 1789)
    }

    func testPart2Example() {
        XCTAssertEqual(day8_2(exampleInput), 8)
    }

    func testPart2() {
        XCTAssertEqual(day8_2(input), 314820)
    }
}
