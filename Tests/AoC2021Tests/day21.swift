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
        let game = DiceGame(player1: 4, player2: 8)
        XCTAssertEqual(game.part2(), 444356092776315)
    }

    func testPart2() {
        XCTAssertEqual(day21_2(), 92399285032143)
    }
}
