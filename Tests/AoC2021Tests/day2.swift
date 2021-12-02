import XCTest
import AoC2021

final class Day2Tests: XCTestCase {

    let example = """
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
    """

    func testPart1Example() {
        XCTAssertEqual(distanceProduct(followingInstructions: example.lines()), 150)
    }

    func testPart1() {
        XCTAssertEqual(day2_1(), 1507611)
    }

    func testPart2() {
        XCTAssertEqual(day2_2(), 0)
    }
}
