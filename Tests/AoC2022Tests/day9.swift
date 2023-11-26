import XCTest
import AoC2022

final class Day9Tests: XCTestCase {

    let input = Bundle.module.text(named: "day9").lines()

    let exampleInput = """
    R 4
    U 4
    L 3
    D 1
    R 4
    D 1
    L 5
    R 2
    """.lines()

    func testPart1Example() {
        XCTAssertEqual(day9_1(exampleInput), 13)
    }

    func testPart1() {
        XCTAssertEqual(day9_1(input), 6367)
    }

    func testPart2Example() {
        XCTAssertEqual(day9_2(exampleInput), 1)
    }

    let exampleInput2 = """
    R 5
    U 8
    L 8
    D 3
    R 17
    D 10
    L 25
    U 20
    """.lines()

    func testPart2Example2() {
        XCTAssertEqual(day9_2(exampleInput2), 36)
    }

    func testPart2() {
        XCTAssertEqual(day9_2(input), 2536)
    }
}
