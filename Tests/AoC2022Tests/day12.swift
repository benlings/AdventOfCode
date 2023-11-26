import XCTest
import AoC2022

final class Day12Tests: XCTestCase {

    let input = Bundle.module.text(named: "day12")

    let exampleInput = """
    Sabqponm
    abcryxxl
    accszExk
    acctuvwj
    abdefghi
    """

    func testPart1Example() {
        XCTAssertEqual(day12_1(exampleInput), 31)
    }

    func testPart1() {
        XCTAssertEqual(day12_1(input), 520)
    }

    func testPart2Example() {
        XCTAssertEqual(day12_2(exampleInput), 29)
    }

    func testPart2() {
        XCTAssertEqual(day12_2(input), 508)
    }
}
