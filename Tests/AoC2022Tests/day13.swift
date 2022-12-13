import XCTest
import AoC2022

final class Day13Tests: XCTestCase {

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
        XCTAssertEqual(DistressSignal(exampleInput).sumRightOrderIndexes(), 13)
    }

    func testPart1() {
        XCTAssertEqual(day13_1(), 5198)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day13_2(), 0)
    }
}
