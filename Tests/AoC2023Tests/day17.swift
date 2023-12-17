import XCTest
import AoC2023

final class Day17Tests: XCTestCase {

  let input = Bundle.module.text(named: "day17")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day17_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day17_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day17_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day17_2(input), 0)
  }
}