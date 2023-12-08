import XCTest
import AoC2023

final class Day8Tests: XCTestCase {

  let input = Bundle.module.text(named: "day8")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day8_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day8_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day8_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day8_2(input), 0)
  }
}