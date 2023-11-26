import XCTest
import AoC2022

final class Day6Tests: XCTestCase {

    let input = Bundle.module.text(named: "day6")

    let exampleInput = """
    mjqjpqmgbljsphdztnvjfqwrcgsmlb
    """

    func testPart1Example() {
        XCTAssertEqual(day6_1(exampleInput), 7)
    }

    func testPart1() {
        XCTAssertEqual(day6_1(input), 1965)
    }

    func testPart2Example() {
        XCTAssertEqual(day6_2(exampleInput), 19)
    }

    func testPart2() {
        XCTAssertEqual(day6_2(input), 2773)
    }
}
