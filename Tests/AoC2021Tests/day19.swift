import XCTest
import AoC2021

final class Day19Tests: XCTestCase {

    func testOrientations() {
        let axes = [Offset3D(x: 1), Offset3D(y: 1), Offset3D(z: 1)]
        let orientedAxes = axes.orientations()
        XCTAssertEqual(orientedAxes.count, 24)
        XCTAssertEqual(orientedAxes.toSet().count, 24)
    }

    let exampleInput = Bundle.module.text(named: "day19example")

    func testPart1Example() {
        var readings = ScannerReadings(exampleInput)
        readings.findMatches()
        XCTAssertEqual(readings.countUniqueBeacons(), 79)
    }

    func testPart1() {
        XCTAssertEqual(day19_1(), 442)
    }

    func testPart2Example() {
        var readings = ScannerReadings(exampleInput)
        readings.findMatches()
        XCTAssertEqual(readings.maxScannerDistance, 3621)
    }

    func testPart2() {
        XCTAssertEqual(day19_2(), 11079)
    }
}
