import XCTest
import AoC2021

final class Day24Tests: XCTestCase {

    let exampleInput = """
    inp w
    add z w
    mod z 2
    div w 2
    add y w
    mod y 2
    div w 2
    add x w
    mod x 2
    div w 2
    mod w 2
    """

    func testPart1Example() {
        var a = ArithmeticLogicUnit(exampleInput)
        XCTAssertEqual(0, 0)
    }

    func testPart1() {
        XCTAssertEqual(day24_1(), 0)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day24_2(), 0)
    }
}
