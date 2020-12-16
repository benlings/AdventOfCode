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
    }

    func testPart1() {
        XCTAssertEqual(day16_1(), 0)
    }

    func testPart2() {
        XCTAssertEqual(day16_2(), 0)
    }
}
