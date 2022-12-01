import XCTest
import AoC2022

final class Day1Tests: XCTestCase {

    let exampleInput = """
    1000
    2000
    3000

    4000

    5000
    6000

    7000
    8000
    9000

    10000
    """

    func testPart1Example() {
        let inventory = Inventory(exampleInput)
        XCTAssertEqual(inventory.mostCalories(), 24000)
    }

    func testPart1() {
        XCTAssertEqual(day1_1(), 71780)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day1_2(), 0)
    }
}
