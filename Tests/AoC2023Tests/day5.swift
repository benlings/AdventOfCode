import XCTest
import AoC2023

final class Day5Tests: XCTestCase {

  let input = Bundle.module.text(named: "day5")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day5_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day5_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day5_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day5_2(input), 0)
  }
}