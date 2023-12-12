import XCTest
import AoC2023

final class Day12Tests: XCTestCase {

  let input = Bundle.module.text(named: "day12")

  let exampleInput = """
  ???.### 1,1,3
  .??..??...?##. 1,1,3
  ?#?#?#?#?#?#?#? 1,3,1,6
  ????.#...#... 4,1,1
  ????.######..#####. 1,6,5
  ?###???????? 3,2,1
  """

  func testPart1Example() {
    XCTAssertEqual(day12_1(exampleInput), 21)
  }

  func testPart1() {
    XCTAssertEqual(day12_1(input), 7251)
  }

  func testPart2Example() {
    XCTAssertEqual(day12_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day12_2(input), 0)
  }
}
