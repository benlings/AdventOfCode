import XCTest
@testable import AoC2020

final class Day9Tests: XCTestCase {

    func testPart1Example() {
        let input = """
        35
        20
        15
        25
        47
        40
        62
        55
        65
        95
        102
        117
        150
        182
        127
        219
        299
        277
        309
        576
        """.lines().compactMap(Int.init)
        let cypher = XMASCypher(preamble: 5)
        XCTAssertEqual(cypher.findFirstInvalid(from: input), 127)
    }

    func testPart1() {
        XCTAssertEqual(day9_1(), 22406676)
    }

    func testPart2() {
        XCTAssertEqual(day9_2(), 0)
    }
}
