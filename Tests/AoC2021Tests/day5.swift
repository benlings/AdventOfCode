import XCTest
import AoC2021

final class Day5Tests: XCTestCase {

    let exampleInput = """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """.lines()

    func testPart1Example() {
        XCTAssertEqual(VentField.countOverlappingLines(exampleInput), 5)
    }

    func testPart1() {
        XCTAssertEqual(day5_1(), 8622)
    }

    func testPart2() {
        XCTAssertEqual(day5_2(), 0)
    }
}
