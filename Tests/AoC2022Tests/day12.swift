import XCTest
import AoC2022

final class Day12Tests: XCTestCase {

    let exampleInput = """
    Sabqponm
    abcryxxl
    accszExk
    acctuvwj
    abdefghi
    """

    func testPart1Example() {
        XCTAssertEqual(HeightMap(exampleInput).findShortestPath(), 31)
    }

    func testPart1() {
        XCTAssertEqual(day12_1(), 520)
    }

    func testPart2Example() {
        XCTAssertEqual(HeightMap(exampleInput).findAnyShortestPath(), 29)
    }

    func testPart2() {
        XCTAssertEqual(day12_2(), 508)
    }
}
