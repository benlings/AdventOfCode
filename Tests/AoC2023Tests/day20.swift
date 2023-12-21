import XCTest
import AoC2023

final class Day20Tests: XCTestCase {

  let input = Bundle.module.text(named: "day20")

  let exampleInput1 = """
  broadcaster -> a, b, c
  %a -> b
  %b -> c
  %c -> inv
  &inv -> a
  """

  func testPart1Example1() {
    XCTAssertEqual(day20_1(exampleInput1), 32000000)
  }

  let exampleInput2 = """
  broadcaster -> a
  %a -> inv, con
  &inv -> b
  %b -> con
  &con -> output
  """

  func testPart1Example2() {
    XCTAssertEqual(day20_1(exampleInput2), 11687500)
  }

  func testPart1() {
    XCTAssertEqual(day20_1(input), 743871576)
  }

  func testPart2() {
    XCTAssertEqual(day20_2(input), 0)
  }
}
