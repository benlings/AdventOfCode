import XCTest
import AoC2021

final class Day20Tests: XCTestCase {

    let exampleInput = Bundle.module.text(named: "day20example")

    func testPart1Example() {
        var map = TrenchMap(exampleInput)
        map.enhance()
        map.enhance()
        XCTAssertEqual(map.pixelCount, 35)
    }

    func testPart1() {
        XCTAssertEqual(day20_1(), 0)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day20_2(), 0)
    }
}
