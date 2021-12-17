import XCTest
import AoC2021

final class Day17Tests: XCTestCase {

    let exampleInput = """
    """

    func testPart1Example() {
        // target area: x=20..30, y=-10..-5
        let probe = ProbeToss(targetHeight: (-10)...(-5))
        XCTAssertEqual(probe.maxHeight(), 45)
    }

    func testPart1() {
        XCTAssertEqual(day17_1(), 2278)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day17_2(), 0)
    }
}
