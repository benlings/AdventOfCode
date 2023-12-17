import XCTest
import AoC2023

final class Day17Tests: XCTestCase {

  let input = Bundle.module.text(named: "day17")

  let exampleInput = """
  2413432311323
  3215453535623
  3255245654254
  3446585845452
  4546657867536
  1438598798454
  4457876987766
  3637877979653
  4654967986887
  4564679986453
  1224686865563
  2546548887735
  4322674655533
  """

  func testPart1Example() {
    XCTAssertEqual(day17_1(exampleInput), 102)
  }

  func testPart1() {
    XCTAssertEqual(day17_1(input), 1256)
  }

  func testPart2Example() {
    XCTAssertEqual(day17_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day17_2(input), 0)
  }
}
