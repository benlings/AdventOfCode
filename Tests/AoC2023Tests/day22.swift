import XCTest
import AoC2023

final class Day22Tests: XCTestCase {

  let input = Bundle.module.text(named: "day22")

  let exampleInput = """
  """

  func testPart1Example() {
    XCTAssertEqual(day22_1(exampleInput), 0)
  }

  func testPart1() {
    XCTAssertEqual(day22_1(input), 0)
  }

  func testPart2Example() {
    XCTAssertEqual(day22_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day22_2(input), 0)
  }
}