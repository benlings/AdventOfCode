import XCTest
import AoC2023

final class Day10Tests: XCTestCase {

  let input = Bundle.module.text(named: "day10")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day10_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day10_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day10_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day10_2(input), 0)
  }
}