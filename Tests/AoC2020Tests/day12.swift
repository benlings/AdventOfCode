import XCTest
@testable import AoC2020

final class Day12Tests: XCTestCase {

    let exampleInput = """
        F10
        N3
        F7
        R90
        F11
    """

    func testPart1Example() {
        XCTAssertEqual(distance(followingInstructions: exampleInput), 25)
    }

    func testPart1() {
        XCTAssertEqual(day12_1(), 1603)
    }

    func testPart2() {
        XCTAssertEqual(day12_2(), 0)
    }
}
