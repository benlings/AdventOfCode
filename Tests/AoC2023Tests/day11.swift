import XCTest
import AoC2023

final class Day11Tests: XCTestCase {

  let input = Bundle.module.text(named: "day11")

  let exampleInput = """
  ...#......
  .......#..
  #.........
  ..........
  ......#...
  .#........
  .........#
  ..........
  .......#..
  #...#.....
  """

  func testPart1Example() {
    XCTAssertEqual(day11_1(exampleInput), 374)
  }

  func testPart1() {
    XCTAssertEqual(day11_1(input), 10289334)
  }

  func testPart2Example() {
    XCTAssertEqual(galaxyDistances(exampleInput, expansionFactor: 10), 1030)
    XCTAssertEqual(galaxyDistances(exampleInput, expansionFactor: 100), 8410)
  }

  func testPart2() {
    XCTAssertEqual(day11_2(input), 649862989626)
  }
}
