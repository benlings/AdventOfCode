import XCTest
@testable import AoC2015

final class Day2Tests: XCTestCase {

    func testPart1Examples() {
        XCTAssertEqual(Present("2x3x4")!.wrappingArea, 58)
        XCTAssertEqual(Present("1x1x10")!.wrappingArea, 43)
    }

    func testPart1() {
        XCTAssertEqual(day2_1(), 1606483)
    }

    func testPart2Examples() {
        XCTAssertEqual(Present("2x3x4")!.ribbonLength, 34)
        XCTAssertEqual(Present("1x1x10")!.ribbonLength, 14)
    }

    func testPart2() {
        XCTAssertEqual(day2_2(), 3842356)
    }
}
