import XCTest
import AoC2022

final class Day3Tests: XCTestCase {

    let input = Bundle.module.text(named: "day3").lines()

    let exampleInput = """
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw
    """.lines()

    func testPart1Example() {
        XCTAssertEqual(day3_1(exampleInput), 157)
    }

    func testPart1() {
        XCTAssertEqual(day3_1(input), 8240)
    }

    func testPart2Example() {
        XCTAssertEqual(day3_2(exampleInput), 70)
    }

    func testPart2() {
        XCTAssertEqual(day3_2(input), 2587)
    }
}
