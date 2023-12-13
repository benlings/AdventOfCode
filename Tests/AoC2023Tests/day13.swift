import XCTest
import AoC2023

final class Day13Tests: XCTestCase {

  let input = Bundle.module.text(named: "day13")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day13_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day13_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day13_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day13_2(input), 0)
  }
}