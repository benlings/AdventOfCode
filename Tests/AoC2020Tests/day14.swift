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

    func testPart2Example() {
        let input = """
        mask = 000000000000000000000000000000X1001X
        mem[42] = 100
        mask = 00000000000000000000000000000000X0XX
        mem[26] = 1
        """
        let instructions = MemInstructions(input)
        XCTAssertEqual(instructions.execute(mode: .v2), 208)
    }

    func testPart2() {
        XCTAssertEqual(day14_2(), 0)
    }
}
