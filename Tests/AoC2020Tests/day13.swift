import XCTest
import AoC2020

final class Day13Tests: XCTestCase {

    func testPart1Example() {
        let input = """
        939
        7,13,x,x,59,x,31,19
        """
        let timetable = BusTimetable(input)
        XCTAssertEqual(timetable.answer(), 295)
    }

    func testPart1() {
        XCTAssertEqual(day13_1(), 6559)
    }

    func testPart2() {
        XCTAssertEqual(day13_2(), 0)
    }
}
