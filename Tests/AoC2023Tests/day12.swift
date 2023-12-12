import XCTest
import AoC2023

final class Day12Tests: XCTestCase {

  let input = Bundle.module.text(named: "day12")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day12_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day12_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day12_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day12_2(input), 0)
  }
}