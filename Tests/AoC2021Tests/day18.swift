import XCTest
import AoC2021

final class Day18Tests: XCTestCase {

    let exampleInput = "[[1,9],[8,5]]"

    func testParseNumber() {
        let n = SnailfishNumber(exampleInput)
        XCTAssertEqual(n, .pair(.pair(.regular(1), .regular(9)), .pair(.regular(8), .regular(5))))
    }

    func testPart1() {
        XCTAssertEqual(day18_1(), 0)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day18_2(), 0)
    }
}
