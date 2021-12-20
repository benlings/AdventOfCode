import XCTest
import AoC2021

final class Day20Tests: XCTestCase {

    let exampleInput = Bundle.module.text(named: "day20example")

    func testPart1Example() {
        var map = TrenchMap(exampleInput)
        map.enhance(count: 2)
        XCTAssertEqual(map.pixelCount, 35)
    }

    func testPart1() {
        XCTAssertEqual(day20_1(), 5884)
    }

    func testPart2Example() {
        var map = TrenchMap(exampleInput)
        map.enhance(count: 50)
        XCTAssertEqual(map.pixelCount, 3351)
    }

    func testPart2() {
        XCTAssertEqual(day20_2(), 6765)
    }
}
