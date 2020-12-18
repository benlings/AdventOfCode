import XCTest
import AoC2020

final class Day18Tests: XCTestCase {

    func testPart1Eaxmple1() {
        XCTAssertEqual(evalExpr("1 + 2 * 3 + 4 * 5 + 6"), 71)
    }

    func testPart1Eaxmple2() {
        XCTAssertEqual(evalExpr("1 + (2 * 3) + (4 * (5 + 6))"), 51)
    }

    func testPart1() {
        XCTAssertEqual(day18_1(), 45283905029161)
    }

    func testPart2Eaxmple1() {
        XCTAssertEqual(evalExpr2("1 + 2 * 3 + 4 * 5 + 6"), 231)
    }

    func testPart2Eaxmple2() {
        XCTAssertEqual(evalExpr2("1 + (2 * 3) + (4 * (5 + 6))"), 51)
    }

    func testPart2Eaxmple6() {
        XCTAssertEqual(evalExpr2("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"), 23340)
    }

    func testPart2() {
        XCTAssertEqual(day18_2(), 216975281211165)
    }
}
