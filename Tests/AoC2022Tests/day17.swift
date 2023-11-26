import XCTest
import AoC2022

final class Day17Tests: XCTestCase {

    let input = Bundle.module.text(named: "day17")

    let exampleInput = """
    >>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>
    """

    func testPart1Example() {
        XCTAssertEqual(day17_1(exampleInput), 3068)
    }

    func testPart1() {
        XCTAssertEqual(day17_1(input), 3224)
    }

    func testPart2Example() {
        XCTAssertEqual(day17_1(exampleInput), 0)
    }

    func testPart2() {
        XCTAssertEqual(day17_1(input), 0)
    }
}
