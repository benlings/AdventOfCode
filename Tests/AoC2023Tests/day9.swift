import XCTest
import AoC2023

final class Day9Tests: XCTestCase {

  let input = Bundle.module.text(named: "day9")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day9_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day9_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day9_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day9_2(input), 0)
  }
}