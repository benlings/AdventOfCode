import XCTest
import AoC2015

final class Day4Tests: XCTestCase {

    func testPart1Examples() {
        XCTAssertEqual(AdventCoinMiner("abcdef").mineCoin(), 609043)
        XCTAssertEqual(AdventCoinMiner("pqrstuv").mineCoin(), 1048970)
    }

    func testPart1() {
        XCTAssertEqual(day4_1(), 282749)
    }

    func testPart2() {
        XCTAssertEqual(day4_2(), 9962624)
    }
}
