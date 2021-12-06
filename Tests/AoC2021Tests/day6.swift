import XCTest
import AoC2021

final class Day6Tests: XCTestCase {

    let exampleInput = "3,4,3,1,2"

    func testPart1Example() {
        let count = School.simulate(ages: exampleInput.commaSeparated().ints(), days: 80)
        XCTAssertEqual(count, 5934)
    }

    func testPart1() {
        XCTAssertEqual(day6_1(), 353274)
    }

    func testPart2Example() {
        let count = School.simulate(ages: exampleInput.commaSeparated().ints(), days: 256)
        XCTAssertEqual(count, 26984457539)
    }

    func testPart2() {
        XCTAssertEqual(day6_2(), 1609314870967)
    }
}
