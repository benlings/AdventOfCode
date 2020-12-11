import XCTest
@testable import AoC2020

final class Day11Tests: XCTestCase {

    func testPart1Example() {
        let input = """
        L.LL.LL.LL
        LLLLLLL.LL
        L.L.L..L..
        LLLL.LL.LL
        L.LL.LL.LL
        L.LLLLL.LL
        ..L.L.....
        LLLLLLLLLL
        L.LLLLLL.L
        L.LLLLL.LL
        """
        var waitingArea = WaitingArea(input)
        XCTAssertEqual(waitingArea.description, input)
    }

    func testPart1() {
        XCTAssertEqual(day11_1(), 0)
    }

    func testPart2() {
        XCTAssertEqual(day11_2(), 0)
    }
}
