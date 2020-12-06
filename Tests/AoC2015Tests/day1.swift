import XCTest
@testable import AoC2015

final class Day1Tests: XCTestCase {

    func testPart1Examples() {
        XCTAssertEqual(elevator("(())"), 0)
        XCTAssertEqual(elevator("()()"), 0)
        XCTAssertEqual(elevator("((("), 3)
        XCTAssertEqual(elevator("(()(()("), 3)
        XCTAssertEqual(elevator("())"), -1)
        XCTAssertEqual(elevator("))("), -1)
        XCTAssertEqual(elevator(")))"), -3)
        XCTAssertEqual(elevator(")())())"), -3)
    }
    
    func testPart1() {
        XCTAssertEqual(day1_1(), 74)
    }

    func testPart2() {
//        XCTAssertEqual(day1_2(), 192684960)
    }
}
