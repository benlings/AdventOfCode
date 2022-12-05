import XCTest
import AoC2022

final class Day5Tests: XCTestCase {

    let exampleInput = """
        [D]
    [N] [C]
    [Z] [M] [P]
     1   2   3

    move 1 from 2 to 1
    move 3 from 1 to 3
    move 2 from 2 to 1
    move 1 from 1 to 2
    """

    func testPart1Example() {
        XCTAssertEqual(Crates.solve(exampleInput), "CMZ")
    }

    func testPart1() {
        XCTAssertEqual(day5_1(), "TGWSMRBPN")
    }

    func testPart2Example() {
        XCTAssertEqual(Crates.solve(exampleInput, reverse: false), "MCD")
    }

    func testPart2() {
        XCTAssertEqual(day5_2(), "TZLTLWRNF")
    }
}
