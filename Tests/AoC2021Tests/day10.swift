import XCTest
import AoC2021

final class Day10Tests: XCTestCase {

    let exampleInput = """
    [({(<(())[]>[[{[]{<()<>>
    [(()[<>])]({[<{<<[]>>(
    {([(<{}[<>[]}>{[]{[(<()>
    (((({<>}<{<{<>}{[]{[]{}
    [[<[([]))<([[{}[[()]]]
    [{[{({}]{}}([{[{{{}}([]
    {<[[]]>}<{[{[{[]{()[[[]
    [<(<(<(<{}))><([]([]()
    <{([([[(<>()){}]>(<<{{
    <{([{{}}[<[[[<>{}]]]>[]]
    """

    func testPart1Example() {
        let n = NavigationSystem(exampleInput)
        XCTAssertEqual(n.incorrectClosingCharacters(), ["}", ")", "]", ")", ">"])
        XCTAssertEqual(n.incorrectClosingCharacterScores(), 26397)
    }

    func testPart1() {
        XCTAssertEqual(day10_1(), 392367)
    }

    func testPart2Example() {
        let n = NavigationSystem(exampleInput)
        XCTAssertEqual(n.incompleteScores(), [288957, 5566, 1480781, 995444, 294])
    }

    func testPart2() {
        XCTAssertEqual(day10_2(), 2192104158)
    }
}
