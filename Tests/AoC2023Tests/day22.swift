import XCTest
import AoC2023

final class Day22Tests: XCTestCase {

  let input = Bundle.module.text(named: "day22")

  let exampleInput = """
  1,0,1~1,2,1
  0,0,2~2,0,2
  0,2,3~2,2,3
  0,0,4~0,2,4
  2,0,5~2,2,5
  0,1,6~2,1,6
  1,1,8~1,1,9
  """

  func testPart1Example() {
    XCTAssertEqual(day22_1(exampleInput), 5)
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
