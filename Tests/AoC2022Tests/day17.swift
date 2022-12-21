import XCTest
import AoC2022
import AdventCore

final class Day17Tests: XCTestCase {

    let exampleInput = """
    >>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>
    """

    func testPart1Example() {
        XCTAssertEqual(Chamber(exampleInput).maxHeight(count: 2022), 3068)
    }

    func testPart1() {
        XCTAssertEqual(day17_1(), 3224)
    }

    func testPart2Example() {
        XCTAssertEqual(Chamber(exampleInput).maxHeight(count: 1000000000000), 1514285714288)
    }

    func testPart2() {
        XCTAssertEqual(day17_2(), 0)
    }
}
