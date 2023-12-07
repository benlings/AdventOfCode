import XCTest
import AoC2023

final class Day7Tests: XCTestCase {

  let input = Bundle.module.text(named: "day7")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day7_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day7_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day7_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day7_2(input), 0)
  }
}