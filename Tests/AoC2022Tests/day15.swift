import XCTest
import AoC2022

final class Day15Tests: XCTestCase {

    let exampleInput = """
    Sensor at x=2, y=18: closest beacon is at x=-2, y=15
    Sensor at x=9, y=16: closest beacon is at x=10, y=16
    Sensor at x=13, y=2: closest beacon is at x=15, y=3
    Sensor at x=12, y=14: closest beacon is at x=10, y=16
    Sensor at x=10, y=20: closest beacon is at x=10, y=16
    Sensor at x=14, y=17: closest beacon is at x=10, y=16
    Sensor at x=8, y=7: closest beacon is at x=2, y=10
    Sensor at x=2, y=0: closest beacon is at x=2, y=10
    Sensor at x=0, y=11: closest beacon is at x=2, y=10
    Sensor at x=20, y=14: closest beacon is at x=25, y=17
    Sensor at x=17, y=20: closest beacon is at x=21, y=22
    Sensor at x=16, y=7: closest beacon is at x=15, y=3
    Sensor at x=14, y=3: closest beacon is at x=15, y=3
    Sensor at x=20, y=1: closest beacon is at x=15, y=3
    """.lines()

    func testPart1Example() {
        XCTAssertEqual(BeaconSensor.countNonBeacons(exampleInput, row: 10), 26)
    }

    func testPart1() {
        XCTAssertEqual(day15_1(), 4717631)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day15_2(), 0)
    }
}
