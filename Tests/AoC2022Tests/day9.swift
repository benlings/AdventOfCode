import XCTest
import AoC2022

final class Day9Tests: XCTestCase {

    let exampleInput = """
    R 4
    U 4
    L 3
    D 1
    R 4
    D 1
    L 5
    R 2
    """.lines()

    func testPart1Example() {
        XCTAssertEqual(Motion.countTailPositions(exampleInput), 13)
    }

    func testPart1() {
        XCTAssertEqual(day9_1(), 6367)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day9_2(), 0)
    }
}
