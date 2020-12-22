import XCTest
import AoC2020

final class Day9Tests: XCTestCase {

    var cypher: XMASCypher!

    override func setUp() {
        let input: [Int] = """
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
        """.lines().ints()
        cypher = XMASCypher(preamble: 5, input: input)
    }

    func testPart1Example() {
        XCTAssertEqual(cypher.firstInvalid(), 127)
    }

    func testPart1() {
        XCTAssertEqual(day9_1(), 22406676)
    }

    func testPart2Example() {
        let range = cypher.findRange(summingTo: cypher.firstInvalid()!)!
        XCTAssertEqual(range, [15, 25, 47, 40])
        XCTAssertEqual(XMASCypher.encryptionWeakness(range), 62)
    }

    func testPart2() {
        XCTAssertEqual(day9_2(), 2942387)
    }
}
