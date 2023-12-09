import XCTest
import AoC2023

final class Day9Tests: XCTestCase {

  let input = Bundle.module.text(named: "day9")

  let exampleInput = """
  0 3 6 9 12 15
  1 3 6 10 15 21
  10 13 16 21 30 45
  """

  func testPart1Example() {
    XCTAssertEqual(day9_1(exampleInput), 114)
  }

  func testPart1() {
    XCTAssertEqual(day9_1(input), 2175229206)
  }

  func testPart2Example() {
    XCTAssertEqual(day9_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day9_2(input), 0)
  }
}
