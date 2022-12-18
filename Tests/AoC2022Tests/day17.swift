import XCTest
import AoC2022

final class Day17Tests: XCTestCase {

    let exampleInput = """
    >>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>
    """

    func testPart1Example() {
        var chamber = Chamber(exampleInput)
        chamber.simulate(count: 2022)
        XCTAssertEqual(chamber.maxHeight, 3068)
    }

    func testPart1() {
        XCTAssertEqual(day17_1(), 3224)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day17_2(), 0)
    }
}
