import XCTest
import AoC2020

final class Day23Tests: XCTestCase {

    func testPart1Example() {
        var game = CupGame("389125467")
        XCTAssertEqual(game.cupOrder, "25467389")
        game.play(moves: 10)
        XCTAssertEqual(game.cupOrder, "92658374")
        game.play(moves: 90)
        XCTAssertEqual(game.cupOrder, "67384529")
    }

    func testPart1() {
        XCTAssertEqual(day23_1(), "82934675")
    }

    func testPart2StarredCups() {
        let game = CupGame("389125467")
        XCTAssertEqual(game.starredCups(), [2, 5])
    }

    func testPart2() {
        XCTAssertEqual(day23_2(), 0)
    }
}
