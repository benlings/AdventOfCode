import XCTest
import AoC2021

final class Day15Tests: XCTestCase {

    let exampleInput = """
    1163751742
    1381373672
    2136511328
    3694931569
    7463417111
    1319128137
    1359912421
    3125421639
    1293138521
    2311944581
    """

    func testPart1Example() {
        XCTAssertEqual(ChitonMap(exampleInput).findLowestRiskPath(), 40)
    }

    func testPart1() {
        XCTAssertEqual(day15_1(), 553)
    }

    func testPart2Example() {
        XCTAssertEqual(ChitonMap(exampleInput).findLowestRiskPathExpanded(), 315)
    }

    func testPart2() {
        XCTAssertEqual(day15_2(), 2858)
    }
}
