import XCTest
@testable import AoC2020

final class Day8Tests: XCTestCase {

    func testPart1Example() {
        let input = """
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
        """
        var context = Context()
        let instructions = Instructions(input)
        instructions.eval(&context)
        XCTAssertEqual(context.accumulator, 5)
    }

    func testPart1() {
        XCTAssertEqual(day8_1(), 1200)
    }

    func testPart2() {
//        XCTAssertEqual(day8_2(), 0)
    }
}
