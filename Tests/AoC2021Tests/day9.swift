import XCTest
import AoC2021

final class Day9Tests: XCTestCase {

    let exampleInput = """
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    """

    func testPart1Example() {
        XCTAssertEqual(HeightMap.sumRiskLevels(input: exampleInput), 15)
    }

    func testPart1() {
        XCTAssertEqual(day9_1(), 506)
    }

    func testPart2Example() {
        XCTAssertEqual(HeightMap.largestBasinsProduct(input: exampleInput), 1134)
    }

    func testPart2() {
        XCTAssertEqual(day9_2(), 931200)
    }
}
