import XCTest
import AoC2020

final class Day22Tests: XCTestCase {

    let exampleInput = """
        Player 1:
        9
        2
        6
        3
        1

        Player 2:
        5
        8
        4
        7
        10
        """

    func testPart1Example() {
        XCTAssertEqual(CombatGame.winningScore(input: exampleInput), 306)
    }

    func testPart1() {
        XCTAssertEqual(day22_1(), 33559)
    }

    func testPart2Example() {
        XCTAssertEqual(CombatGame.winningScore(input: exampleInput, recursive: true), 291)
    }

    func testPart2() {
        XCTAssertEqual(day22_2(), 0)
    }
}
