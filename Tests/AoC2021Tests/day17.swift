import XCTest
import AoC2021

final class Day17Tests: XCTestCase {

    // target area: x=20..30, y=-10..-5
    let exampleProbe = ProbeToss(targetX: 20...30, targetY: (-10)...(-5))

    func testPart1Example() {
        XCTAssertEqual(exampleProbe.maxHeight(), 45)
    }

    func testPart1() {
        XCTAssertEqual(day17_1(), 2278)
    }

    func testPart2Example() {
        XCTAssertEqual(exampleProbe.countIntialVelocities(), 112)
    }

    func testPart2() {
        XCTAssertEqual(day17_2(), 996)
    }
}
