import XCTest
import AoC2023

final class Day14Tests: XCTestCase {

  let input = Bundle.module.text(named: "day14")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day14_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day14_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day14_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day14_2(input), 0)
  }
}