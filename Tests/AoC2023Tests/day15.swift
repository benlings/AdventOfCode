import XCTest
import AoC2023

final class Day15Tests: XCTestCase {

  let input = Bundle.module.text(named: "day15")

  let exampleInput = """
  rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
  """

  func testPart1Example() {
    XCTAssertEqual(day15_1(exampleInput), 1320)
  }

  func testPart1() {
    XCTAssertEqual(day15_1(input), 516804)
  }

  func testPart2Example() {
    XCTAssertEqual(day15_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day15_2(input), 0)
  }
}
