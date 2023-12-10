import XCTest
import AoC2023

final class Day10Tests: XCTestCase {

  let input = Bundle.module.text(named: "day10")

  let exampleInput1 = """
  -L|F7
  7S-7|
  L|7||
  -L-J|
  L|-JF
  """

  let exampleInput2 = """
  7-F7-
  .FJ|7
  SJLL7
  |F--J
  LJ.LJ
  """

  func testPart1Example1() {
    XCTAssertEqual(day10_1(exampleInput1), 4)
  }

  func testPart1Example2() {
    XCTAssertEqual(day10_1(exampleInput2), 8)
  }

  func testPart1() {
    XCTAssertEqual(day10_1(input), 6846)
  }

  func testPart2Example() {
    XCTAssertEqual(day10_2(exampleInput1), 0)
  }

  func testPart2() {
    XCTAssertEqual(day10_2(input), 0)
  }
}
