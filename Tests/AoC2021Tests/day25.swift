import XCTest
import AoC2021

final class Day25Tests: XCTestCase {

    let exampleInput = """
    v...>>.vv>
    .vv>>.vv..
    >>.>v>...v
    >>v>>.>.v.
    v>v.vv.v..
    >.>>..v...
    .vv..>.>v.
    v.v..>>v.v
    ....v..v.>
    """

    func testPart1Example() {
        var map = CucumberMap(exampleInput)
        XCTAssertEqual(map.stepUntilStable(), 58)
    }

    func testPart1() {
        XCTAssertEqual(day25_1(), 367)
    }

    func testPart2() {
        XCTAssertEqual(day25_2(), 0)
    }
}
