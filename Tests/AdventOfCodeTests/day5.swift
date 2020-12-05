import XCTest
@testable import AdventOfCode

final class Day5Tests: XCTestCase {

    func testPart1Example1() {
        let seat = Seat(bsp: "BFFFBBFRRR")!
        XCTAssertEqual(seat, Seat(row: 70, column: 7))
        XCTAssertEqual(seat.id, 567)
    }

    func testPart1Example2() {
        let seat = Seat(bsp: "FFFBBBFRRR")!
        XCTAssertEqual(seat, Seat(row: 14, column: 7))
        XCTAssertEqual(seat.id, 119)
    }

    func testPart1Example3() {
        let seat = Seat(bsp: "BBFFBBFRLL")!
        XCTAssertEqual(seat, Seat(row: 102, column: 4))
        XCTAssertEqual(seat.id, 820)
    }
    
    func testPart1() {
        XCTAssertEqual(day5_1(), 951)
    }

    func testPart2() {
        XCTAssertEqual(day5_2(), 0)
    }
}
