import XCTest
import AoC2020

final class Day17Tests: XCTestCase {

    let example = GridND("""
        .#.
        ..#
        ###
    """)

    func testPart1Example1() {
        var grid = example
        XCTAssertEqual(grid.countActive(), 5)
        grid.step()
        XCTAssertEqual(grid.countActive(), 11)
    }

    func testPart1Example2() {
        var grid = example
        grid.boot()
        XCTAssertEqual(grid.countActive(), 112)
    }

    func testPart1() {
        XCTAssertEqual(day17_1(), 215)
    }

    func testPart2Example() {
        var grid = GridND("""
            .#.
            ..#
            ###
        """, dimensions: 4)
        grid.boot()
        XCTAssertEqual(grid.countActive(), 848)
    }

    func testPart2() {
        XCTAssertEqual(day17_2(), 1728)
    }
}
