import XCTest
import AoC2023

final class Day19Tests: XCTestCase {

  let input = Bundle.module.text(named: "day19")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day19_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day19_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day19_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day19_2(input), 0)
  }
}