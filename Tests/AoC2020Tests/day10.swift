import XCTest
import AoC2020

final class Day10Tests: XCTestCase {

    func testPart1Example() {
        let input: [Int] = """
        16
        10
        15
        5
        1
        11
        7
        19
        6
        12
        4
        """.lines().ints()
        XCTAssertEqual(differences(input), [3: 5, 1: 7])
    }

    func testPart1() {
        XCTAssertEqual(day10_1(), 2343)
    }

    func testPart2() {
        XCTAssertEqual(day10_2(), 31581162962944)
    }
}
