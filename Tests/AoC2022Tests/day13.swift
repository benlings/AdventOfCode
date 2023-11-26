import XCTest
import AoC2022

final class Day13Tests: XCTestCase {

    let input = Bundle.module.text(named: "day13")

    let exampleInput = """
    [1,1,3,1,1]
    [1,1,5,1,1]

    [[1],[2,3,4]]
    [[1],4]

    [9]
    [[8,7,6]]

    [[4,4],4,4]
    [[4,4],4,4,4]

    [7,7,7,7]
    [7,7,7]

    []
    [3]

    [[[]]]
    [[]]

    [1,[2,[3,[4,[5,6,7]]]],8,9]
    [1,[2,[3,[4,[5,6,0]]]],8,9]
    """

    func testPart1Example() {
        XCTAssertEqual(day13_1(exampleInput), 13)
    }

    func testPart1() {
        XCTAssertEqual(day13_1(input), 5198)
    }

    func testPart2Example() {
        XCTAssertEqual(day13_2(exampleInput), 140)
    }

    func testPart2() {
        XCTAssertEqual(day13_2(input), 22344)
    }
}
