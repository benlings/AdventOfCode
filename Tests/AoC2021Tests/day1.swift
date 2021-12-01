import XCTest
import AoC2021
import Algorithms

final class Day1Tests: XCTestCase {

    let data: [Int] = """
    199
    200
    208
    210
    200
    207
    240
    269
    260
    263
    """.lines().ints()

    func testPart1Example() {
        XCTAssertEqual(countIncreasedDepth(data), 7)
    }

    func testPart1() {
        XCTAssertEqual(day1_1(), 1766)
    }

    func testPart2Example() {
        XCTAssertEqual(countIncreasedDepthWindowed(data), 5)
    }


    func testPart2() {
        XCTAssertEqual(day1_2(), 1797)
    }
}
