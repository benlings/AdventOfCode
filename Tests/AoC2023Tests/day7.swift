import XCTest
import AoC2023

final class Day7Tests: XCTestCase {

  let input = Bundle.module.text(named: "day7")

  let exampleInput = """
  32T3K 765
  T55J5 684
  KK677 28
  KTJJT 220
  QQQJA 483
  """

  func testPart1Example() {
    XCTAssertEqual(day7_1(exampleInput), 6440)
  }

  func testPart1() {
    XCTAssertEqual(day7_1(input), 251806792)
  }

  func testPart2Example() {
    XCTAssertEqual(day7_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day7_2(input), 0)
  }
}
