import XCTest
import AoC2020

final class Day16Tests: XCTestCase {

    func testPart1Example() {
        let input = """
        class: 1-3 or 5-7
        row: 6-11 or 33-44
        seat: 13-40 or 45-50

        your ticket:
        7,1,14

        nearby tickets:
        7,3,47
        40,4,50
        55,2,20
        38,6,12
        """
        let t = TicketTranslation(input)
        XCTAssertEqual(t.invalidNearbyTickets(), [4, 55, 12])
        XCTAssertEqual(t.errorRate(), 71)
    }

    func testPart1() {
        XCTAssertEqual(day16_1(), 20013)
    }

    func testPart2Example() {
        let input = """
        class: 0-1 or 4-19
        row: 0-5 or 8-19
        seat: 0-13 or 16-19

        your ticket:
        11,12,13

        nearby tickets:
        3,9,18
        15,1,5
        5,14,9
        """
        let t = TicketTranslation(input)
        XCTAssertEqual(t.inferredFieldOrder(), ["row", "class", "seat"])
    }

    func testPart2() {
        XCTAssertEqual(day16_2(), 0)
    }
}
