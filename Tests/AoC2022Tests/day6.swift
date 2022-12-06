import XCTest
import AoC2022

final class Day6Tests: XCTestCase {

    let exampleInput = """
    mjqjpqmgbljsphdztnvjfqwrcgsmlb
    """

    func testPart1Example() {
        XCTAssertEqual(findStart(exampleInput), 7)
    }

    func testPart1() {
        XCTAssertEqual(day6_1(), 1965)
    }

    func testPart2Example() {
        XCTAssertEqual(findStart(exampleInput, distinct: 14), 19)
    }

    func testPart2() {
        XCTAssertEqual(day6_2(), 2773)
    }
}
