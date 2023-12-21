import XCTest
import AoC2023

final class Day20Tests: XCTestCase {

  let input = Bundle.module.text(named: "day20")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day20_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day20_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day20_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day20_2(input), 0)
  }
}