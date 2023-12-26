import XCTest
import AoC2023

final class Day25Tests: XCTestCase {

  let input = Bundle.module.text(named: "day25")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day25_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day25_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day25_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day25_2(input), 0)
  }
}