import XCTest
import AoC2023

final class Day21Tests: XCTestCase {

  let input = Bundle.module.text(named: "day21")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day21_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day21_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day21_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day21_2(input), 0)
  }
}