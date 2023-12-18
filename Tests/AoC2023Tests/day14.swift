import XCTest
import AoC2023

final class Day14Tests: XCTestCase {

  let input = Bundle.module.text(named: "day14")

  let exampleInput = """
  O....#....
  O.OO#....#
  .....##...
  OO.#O....O
  .O.....O#.
  O.#..O.#.#
  ..O..#O..O
  .......O..
  #....###..
  #OO..#....
  """

  func testPart1Example() {
    XCTAssertEqual(day14_1(exampleInput), 136)
  }

  func testPart1() {
    XCTAssertEqual(day14_1(input), 108857)
  }

  func testPart2Example() {
    XCTAssertEqual(day14_2(exampleInput), 64)
  }

  func testPart2() {
    XCTAssertEqual(day14_2(input), 95273)
  }
}
