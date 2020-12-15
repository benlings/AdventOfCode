import XCTest
import AoC2020

final class Day15Tests: XCTestCase {

    func testPart1Example() {
        let input = "0,3,6"
        let game = MemoryGame(input)
        XCTAssertEqual(game.numberAt(2020), 436)
    }

    func testPart1() {
        XCTAssertEqual(day15_1(), 0)
    }

    func testPart2() {
        XCTAssertEqual(day15_2(), 0)
    }
}
