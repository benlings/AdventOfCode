import XCTest
@testable import AoC2020

final class Day8Tests: XCTestCase {

    let exampleInstructions = Instructions("""
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
    """)

    func testPart1Example() {
        XCTAssertEqual(exampleInstructions.execute(), 5)
    }

    func testPart1() {
        XCTAssertEqual(day8_1(), 1200)
    }

    func testPart2Example() {
        var instructions = exampleInstructions
        XCTAssertEqual(instructions.fixProgram(), 8)
    }

    func testPart2() {
        XCTAssertEqual(day8_2(), 1023)
    }
}
