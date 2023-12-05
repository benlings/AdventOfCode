import XCTest
import AoC2023

final class Day5Tests: XCTestCase {

  let input = Bundle.module.text(named: "day5")

  let exampleInput = """
  seeds: 79 14 55 13

  seed-to-soil map:
  50 98 2
  52 50 48

  soil-to-fertilizer map:
  0 15 37
  37 52 2
  39 0 15

  fertilizer-to-water map:
  49 53 8
  0 11 42
  42 0 7
  57 7 4

  water-to-light map:
  88 18 7
  18 25 70

  light-to-temperature map:
  45 77 23
  81 45 19
  68 64 13

  temperature-to-humidity map:
  0 69 1
  1 0 69

  humidity-to-location map:
  60 56 37
  56 93 4
  """

  func testPart1Example() {
    XCTAssertEqual(day5_1(exampleInput), 35)
  }

  func testPart1() {
    XCTAssertEqual(day5_1(input), 278755257)
  }

  func testPart2Example() {
    XCTAssertEqual(day5_2(exampleInput), 46)
  }

  func testPart2() {
    XCTAssertEqual(day5_2(input), 0)
  }
}
