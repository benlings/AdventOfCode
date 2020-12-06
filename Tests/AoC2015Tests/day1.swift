import XCTest
@testable import AoC2015

final class Day1Tests: XCTestCase {

    func testPart1Examples() {
        XCTAssertEqual(Elevator(instructions:"(())").finalFloor, 0)
        XCTAssertEqual(Elevator(instructions:"()()").finalFloor, 0)
        XCTAssertEqual(Elevator(instructions:"(((").finalFloor, 3)
        XCTAssertEqual(Elevator(instructions:"(()(()(").finalFloor, 3)
        XCTAssertEqual(Elevator(instructions:"())").finalFloor, -1)
        XCTAssertEqual(Elevator(instructions:"))(").finalFloor, -1)
        XCTAssertEqual(Elevator(instructions:")))").finalFloor, -3)
        XCTAssertEqual(Elevator(instructions:")())())").finalFloor, -3)
    }
    
    func testPart1() {
        XCTAssertEqual(day1_1(), 74)
    }

    func testPart2() {
//        XCTAssertEqual(day1_2(), 192684960)
    }
}
