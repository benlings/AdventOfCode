import XCTest
import AoC2022

final class Day5Tests: XCTestCase {

    let input = Bundle.module.text(named: "day5")

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
        XCTAssertEqual(day5_1(exampleInput), "CMZ")
    }

    func testPart1() {
        XCTAssertEqual(day5_1(input), "TGWSMRBPN")
    }

    func testPart2Example() {
        XCTAssertEqual(day5_2(exampleInput), "MCD")
    }

    func testPart2() {
        XCTAssertEqual(day5_2(input), "TZLTLWRNF")
    }
}
