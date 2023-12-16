import XCTest
import AoC2023

final class Day15Tests: XCTestCase {

  let input = Bundle.module.text(named: "day15")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day15_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day15_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day15_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day15_2(input), 0)
  }
}