import XCTest
import AoC2023

final class Day18Tests: XCTestCase {

  let input = Bundle.module.text(named: "day18")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day18_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day18_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day18_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day18_2(input), 0)
  }
}