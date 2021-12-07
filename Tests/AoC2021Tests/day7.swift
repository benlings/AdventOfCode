import XCTest
import AoC2021

final class Day7Tests: XCTestCase {

    let exampleInput = "16,1,2,0,4,2,7,1,2,14"

    func testPart1Example() {
        XCTAssertEqual(CrabSwarm(exampleInput).findMinFuelCost(), 37)
    }

    func testPart1() {
        XCTAssertEqual(day7_1(), 331067)
    }

    func testPart2() {
        XCTAssertEqual(day7_2(), 0)
    }
}
