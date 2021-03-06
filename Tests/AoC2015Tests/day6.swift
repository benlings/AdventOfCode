import XCTest
import AoC2015

final class Day6Tests: XCTestCase {

    func testPart1Example() {
        let input = """
        turn on 0,0 through 999,999
        toggle 0,0 through 999,0
        turn off 499,499 through 500,500
        """
        XCTAssertEqual(LightGrid(input).evaluate().count, 998_996)
    }

    func testPart1() {
        XCTAssertEqual(day6_1(), 400410)
    }

    func testPart2Example() {
        let input = """
        turn on 0,0 through 0,0
        toggle 0,0 through 999,999
        """
        XCTAssertEqual(LightGrid(input).totalBrightness(), 2000001)
    }

    func testPart2() {
        XCTAssertEqual(day6_2(), 15343601)
    }
}
