import XCTest
import AoC2020

final class Day17Tests: XCTestCase {

    let example = GridND("""
        .#.
        ..#
        ###
    """)

    func testPart1Example() {
        XCTAssertEqual(example.boot(), 112)
    }

    func testPart1() {
        XCTAssertEqual(day17_1(), 215)
    }

    func testPart2Example() {
        let grid = GridND("""
            .#.
            ..#
            ###
        """, dimensions: 4)
        XCTAssertEqual(grid.boot(), 848)
    }

    func testPart2() {
        XCTAssertEqual(day17_2(), 1728)
    }
}
