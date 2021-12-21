import XCTest
import AoC2021

final class Day21Tests: XCTestCase {

    func testPart1Example() {
        var game = DiceGame(player1: 4, player2: 8)
        XCTAssertEqual(game.part1(), 739785)
    }

    func testPart1() {
        XCTAssertEqual(day21_1(), 713328)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day21_2(), 0)
    }
}
