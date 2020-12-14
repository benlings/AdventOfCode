import XCTest
@testable import AoC2020

final class Day14Tests: XCTestCase {

    func testPart1Example() {
        let input = """
        mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
        mem[8] = 11
        mem[7] = 101
        mem[8] = 0
        """
        let instructions = MemInstructions(input)
        XCTAssertEqual(instructions.execute(), 165)
    }

    func testPart1() {
        XCTAssertEqual(day14_1(), 5055782549997)
    }

    func testPart2() {
        XCTAssertEqual(day14_2(), 0)
    }
}
