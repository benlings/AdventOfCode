import XCTest
import AoC2023

final class Day2Tests: XCTestCase {

    let input = Bundle.module.text(named: "day2")

    let exampleInput = """
    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    """

    func testPart1Example() {
        XCTAssertEqual(day2_1(exampleInput), 8)
    }

    func testPart1() {
        XCTAssertEqual(day2_1(input), 3059)
    }

    func testPart2Example() {
        XCTAssertEqual(day2_2(exampleInput), 2286)
    }

    func testPart2() {
      XCTAssertEqual(day2_2(input), 65371)
    }
}
