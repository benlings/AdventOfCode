import XCTest
import AoC2022

final class Day8Tests: XCTestCase {

    let exampleInput = """
    30373
    25512
    65332
    33549
    35390
    """

    func testPart1Example() {
        XCTAssertEqual(TreeMap(exampleInput).visibleTreeCount(), 21)
    }

    func testPart1() {
        XCTAssertEqual(day8_1(), 1789)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day8_2(), 0)
    }
}
