import XCTest
import AoC2021

final class Day4Tests: XCTestCase {

    let exampleInput = """
    7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

    22 13 17 11  0
     8  2 23  4 24
    21  9 14 16  7
     6 10  3 18  5
     1 12 20 15 19

     3 15  0  2 22
     9 18 13 17  5
    19  8  7 25 23
    20 11 10 24  4
    14 21 16 12  6

    14 21 17 24  4
    10 16 15  9 19
    18  8 23 26 20
    22 11 13  6  5
     2  0 12  3  7
    """

    func testReadExampleInput() {
        let game = BingoGame(exampleInput)
        XCTAssertEqual(game.pickedNumbers, [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1])
        XCTAssertEqual(game.boards.count, 3)
    }

    func testPart1Example() {
        var game = BingoGame(exampleInput)
        let score = game.findWiningGame()
        XCTAssertEqual(score, 4512)
    }

    func testPart1() {
        XCTAssertEqual(day4_1(), 51776)
    }

    func testPart2Example() {
        var game = BingoGame(exampleInput)
        let score = game.findLosingGame()
        XCTAssertEqual(score, 1924)
    }

    func testPart2() {
        XCTAssertEqual(day4_2(), 16830)
    }
}
