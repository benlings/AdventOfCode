import XCTest
import AoC2022

final class Day3Tests: XCTestCase {

    let exampleInput = """
    vJrwpWtwJgWrhcsFMMfFFhFp
    jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
    PmmdzqPrVvPwwTWBwg
    wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
    ttgJtRGJQctTZtZT
    CrZsJsPPZsGzwwsLwLmpwMDw
    """.lines()

    func testPart1Example() {
        XCTAssertEqual(Rucksack.sumErrorPriorities(exampleInput), 157)
    }

    func testPart1() {
        XCTAssertEqual(day3_1(), 8240)
    }

    func testPart2Example() {
        XCTAssertEqual(Rucksack.sumBadgePriorities(exampleInput), 70)
    }

    func testPart2() {
        XCTAssertEqual(day3_2(), 2587)
    }
}
