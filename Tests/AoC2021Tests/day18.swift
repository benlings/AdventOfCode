import XCTest
import AoC2021

final class Day18Tests: XCTestCase {

    let exampleInput = "[[1,9],[8,5]]"

    func testParseNumber() {
        let n = SnailfishNumber(exampleInput)
        XCTAssertEqual(n, .pair(.pair(.regular(1), .regular(9)), .pair(.regular(8), .regular(5))))
    }

    func testAddFirst() {
        var n = SnailfishNumber(exampleInput)
        n.addFirst(n: 5)
        XCTAssertEqual(n.description, "[[6,9],[8,5]]")
    }

    func explodeEqual(_ number: String, _ exploded: String) {
        var n = SnailfishNumber(number)
        XCTAssertEqual(n.explodeFirst(), number != exploded)
        XCTAssertEqual(n.description, exploded)
    }

    func testExplode() {
        explodeEqual("[[6,9],[8,5]]", "[[6,9],[8,5]]")
        explodeEqual("[[[[[9,8],1],2],3],4]", "[[[[0,9],2],3],4]")
        explodeEqual("[7,[6,[5,[4,[3,2]]]]]", "[7,[6,[5,[7,0]]]]")
        explodeEqual("[[6,[5,[4,[3,2]]]],1]", "[[6,[5,[7,0]]],3]")
        explodeEqual("[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]", "[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]")
        explodeEqual("[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]", "[[3,[2,[8,0]]],[9,[5,[7,0]]]]")
    }

    func splitEqual(_ number: String, _ split: String) {
        var n = SnailfishNumber(number)
        XCTAssertEqual(n.splitFirst(), number != split)
        XCTAssertEqual(n.description, split)
    }

    func testSplit() {
        splitEqual("[[[[0,7],4],[15,[0,13]]],[1,1]]", "[[[[0,7],4],[[7,8],[0,13]]],[1,1]]")
        splitEqual("[[[[0,7],4],[[7,8],[0,13]]],[1,1]]", "[[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]")
        splitEqual("[[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]", "[[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]")
    }

    func testPart1() {
        XCTAssertEqual(day18_1(), 0)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day18_2(), 0)
    }
}
