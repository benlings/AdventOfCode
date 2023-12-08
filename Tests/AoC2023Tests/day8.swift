import XCTest
import AoC2023

final class Day8Tests: XCTestCase {

  let input = Bundle.module.text(named: "day8")

  let exampleInput1 = """
  RL

  AAA = (BBB, CCC)
  BBB = (DDD, EEE)
  CCC = (ZZZ, GGG)
  DDD = (DDD, DDD)
  EEE = (EEE, EEE)
  GGG = (GGG, GGG)
  ZZZ = (ZZZ, ZZZ)
  """

  func testPart1Example1() {
    XCTAssertEqual(day8_1(exampleInput1), 2)
  }

  let exampleInput2 = """
  LLR

  AAA = (BBB, BBB)
  BBB = (AAA, ZZZ)
  ZZZ = (ZZZ, ZZZ)
  """

  func testPart1Example2() {
    XCTAssertEqual(day8_1(exampleInput2), 6)
  }

  func testPart1() {
    XCTAssertEqual(day8_1(input), 11309)
  }

  let exampleInput3 = """
  """

  func testPart2Example() {
    XCTAssertEqual(day8_2(exampleInput3), 6)
  }

  func testPart2() {
    XCTAssertEqual(day8_2(input), 0)
  }
}