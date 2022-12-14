import XCTest
import AoC2022

final class Day14Tests: XCTestCase {

    let exampleInput = """
    498,4 -> 498,6 -> 496,6
    503,4 -> 502,4 -> 502,9 -> 494,9
    """.lines()

    func testPart1Example() {
        XCTAssertEqual(CaveStructure(exampleInput).countSand(), 24)
    }

    func testPart1() {
        XCTAssertEqual(day14_1(), 825)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day14_2(), 0)
    }
}
