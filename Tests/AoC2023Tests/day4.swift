import XCTest
import AoC2023

final class Day4Tests: XCTestCase {

  let input = Bundle.module.text(named: "day4")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day4_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day4_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day4_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day4_2(input), 0)
  }
}