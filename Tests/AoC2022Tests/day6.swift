import XCTest
import AoC2022

final class Day6Tests: XCTestCase {

    let exampleInput = """
    mjqjpqmgbljsphdztnvjfqwrcgsmlb
    """

    func testPart1Example() {
        XCTAssertEqual(findStartOfPacket(exampleInput), 7)
    }

    func testPart1() {
        XCTAssertEqual(day6_1(), 1965)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day6_2(), 0)
    }
}
