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
        var alu = ArithmeticLogicUnit(exampleInput)
        var input = [15]
        alu.run(input: &input)
        XCTAssertEqual(alu.variableValues, [1, 1, 1, 1])
    }

    func testMonadDigits() {
        let alu = ArithmeticLogicUnit.monad
        // 16 11 . . 12 2 . 4 12 . . . . 15
        let number = 12993495699997
        let result = alu.valid(input: number)
        XCTAssertEqual(result, (((((((1 + 16) * 26 + (2 + 11)) * 26 + (3 + 12)) * 26 + (4 + 2)) * 26) + (5 + 4)) * 26 + (6 + 12)) * 26 + (7 + 15))
    }

    func testMonadDigits2() {
        let alu = ArithmeticLogicUnit.monad
        // . . . 5 3 . . 16 . . 7 11 6 11
        let number = 41299994879959
        let result = alu.valid(input: number)
        XCTAssertEqual(result, 0)
    }

    func testPart1() {
        XCTAssertEqual(day24_1(), 41299994879959)
    }

    func testPart2() {
        XCTAssertEqual(day24_2(), 11189561113216)
    }
}
