import XCTest
import AoC2015

final class Day3Tests: XCTestCase {

    func testPart1Examples() {
        XCTAssertEqual(DeliveryRoute(">").countHouses, 2)
        XCTAssertEqual(DeliveryRoute("^>v<").countHouses, 4)
        XCTAssertEqual(DeliveryRoute("^v^v^v^v^v").countHouses, 2)
    }

    func testPart1() {
        XCTAssertEqual(day3_1(), 2565)
    }

    func testPart2() {
        XCTAssertEqual(day3_2(), 0)
    }
}
