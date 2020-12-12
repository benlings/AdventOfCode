import XCTest
@testable import AoC2020

final class Day12Tests: XCTestCase {

    func testPart1Example() {
        let input = """
            F10
            N3
            F7
            R90
            F11
        """
        let instructions = parseInstructions(input.lines())
        var position = Position()
        position.move(following: instructions)
        XCTAssertEqual(position.manhattanDistanceToOrigin(), 25)
    }

    func testPart1() {
        XCTAssertEqual(day12_1(), 0)
    }

    func testPart2() {
        XCTAssertEqual(day12_2(), 0)
    }
}
