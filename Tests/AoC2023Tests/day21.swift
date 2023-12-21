import XCTest
import AoC2023

final class Day21Tests: XCTestCase {

  let input = Bundle.module.text(named: "day21")

  let exampleInput = """
  ...........
  .....###.#.
  .###.##..#.
  ..#.#...#..
  ....#.#....
  .##..S####.
  .##..#...#.
  .......##..
  .##.#.####.
  .##..##.##.
  ...........
  """

  func testPart1Example() {
    XCTAssertEqual(day21_1(exampleInput, steps: 6), 16)
  }

  func testPart1() {
    XCTAssertEqual(day21_1(input, steps: 64), 3729)
  }

  func testPart2Example() {
    XCTAssertEqual(day21_2(exampleInput, steps: 6), 16)
    XCTAssertEqual(day21_2(exampleInput, steps: 10), 50)
    XCTAssertEqual(day21_2(exampleInput, steps: 50), 1594)
    XCTAssertEqual(day21_2(exampleInput, steps: 100), 6536)
    XCTAssertEqual(day21_2(exampleInput, steps: 500), 167004)
    XCTAssertEqual(day21_2(exampleInput, steps: 1000), 668697)
    XCTAssertEqual(day21_2(exampleInput, steps: 5000), 16733044)
  }

  func testPart2() {
    XCTAssertEqual(day21_2(input, steps: 26501365), 0)
  }
}
