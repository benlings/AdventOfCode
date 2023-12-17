import XCTest
import AoC2023

final class Day16Tests: XCTestCase {

  let input = Bundle.module.text(named: "day16")

  let exampleInput = #"""
  .|...\....
  |.-.\.....
  .....|-...
  ........|.
  ..........
  .........\
  ..../.\\..
  .-.-/..|..
  .|....-|.\
  ..//.|....
  """#

  func testPart1Example() {
    XCTAssertEqual(day16_1(exampleInput), 46)
  }

  func testPart1() {
    XCTAssertEqual(day16_1(input), 7034)
  }

  func testPart2Example() {
    XCTAssertEqual(day16_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day16_2(input), 0)
  }
}
