import XCTest
import AoC2022

final class Day2Tests: XCTestCase {

    let exampleInput = """
    A Y
    B X
    C Z
    """.lines()

    func testPart1Example() {
        XCTAssertEqual(GameMove.totalScore1(guide: exampleInput), 15)
    }

    func testPart1() {
        XCTAssertEqual(day2_1(), 10404)
    }

    func testPart2Example() {
        XCTAssertEqual(GameMove.totalScore2(guide: exampleInput), 12)
    }

    func testPart2() {
        XCTAssertEqual(day2_2(), 10334)
    }
}
