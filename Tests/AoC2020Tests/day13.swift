import XCTest
import AoC2020

final class Day13Tests: XCTestCase {

    let timetable = BusTimetable("""
    939
    7,13,x,x,59,x,31,19
    """)

    func testPart1Example() {
        XCTAssertEqual(timetable.answer(), 295)
    }

    func testPart1() {
        XCTAssertEqual(day13_1(), 6559)
    }

    func testPart2Example() {
        XCTAssertEqual(timetable.earliestTimestampMatchingOffsets(), 1068781)
    }

    func testPart2() {
        XCTAssertEqual(day13_2(), 626670513163231)
    }
}
