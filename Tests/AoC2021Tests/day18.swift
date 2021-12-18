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

    func testActionsStepByStep() {
        let n1 = SnailfishNumber("[[[[4,3],4],4],[7,[[8,4],9]]]")
        let n2 = SnailfishNumber("[1,1]")
        var n = SnailfishNumber.pair(n1, n2)
        XCTAssertEqual(n.description, "[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]")
        XCTAssertTrue(n.reduceAction())
        XCTAssertEqual(n.description, "[[[[0,7],4],[7,[[8,4],9]]],[1,1]]")
        XCTAssertTrue(n.reduceAction())
        XCTAssertEqual(n.description, "[[[[0,7],4],[15,[0,13]]],[1,1]]")
        XCTAssertTrue(n.reduceAction())
        XCTAssertEqual(n.description, "[[[[0,7],4],[[7,8],[0,13]]],[1,1]]")
        XCTAssertTrue(n.reduceAction())
        XCTAssertEqual(n.description, "[[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]")
        XCTAssertTrue(n.reduceAction())
        XCTAssertEqual(n.description, "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]")
        XCTAssertFalse(n.reduceAction())
    }

    func testReduce() {
        let n1 = SnailfishNumber("[[[[4,3],4],4],[7,[[8,4],9]]]")
        let n2 = SnailfishNumber("[1,1]")
        var n = SnailfishNumber.pair(n1, n2)
        n.reduce()
        XCTAssertEqual(n.description, "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]")
    }

    func testAdd() {
        let n = SnailfishNumber("[[[[4,3],4],4],[7,[[8,4],9]]]") + SnailfishNumber("[1,1]")
        XCTAssertEqual(n.description, "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]")
    }

    func testMagnitude() {
        XCTAssertEqual(SnailfishNumber("[[1,2],[[3,4],5]]").magnitude, 143)
        XCTAssertEqual(SnailfishNumber("[[[[0,7],4],[[7,8],[6,0]]],[8,1]]").magnitude, 1384)
        XCTAssertEqual(SnailfishNumber("[[[[1,1],[2,2]],[3,3]],[4,4]]").magnitude, 445)
        XCTAssertEqual(SnailfishNumber("[[[[3,0],[5,3]],[4,4]],[5,5]]").magnitude, 791)
        XCTAssertEqual(SnailfishNumber("[[[[5,0],[7,4]],[5,5]],[6,6]]").magnitude, 1137)
        XCTAssertEqual(SnailfishNumber("[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]").magnitude, 3488)
    }

    func assertSumEquals(_ input: String, expected: String) {
        let sum = SnailfishNumber.sum(input.lines())
        XCTAssertEqual(sum?.description, expected);
    }

    func testSum() {
        let input = """
        [1,1]
        [2,2]
        [3,3]
        [4,4]
        """
        assertSumEquals(input, expected: "[[[[1,1],[2,2]],[3,3]],[4,4]]")
        let input2 = """
        [1,1]
        [2,2]
        [3,3]
        [4,4]
        [5,5]
        """
        assertSumEquals(input2, expected: "[[[[3,0],[5,3]],[4,4]],[5,5]]")
    }

    func testSumStepByStep() {
        var n = SnailfishNumber("[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]")
        n += SnailfishNumber("[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]")
        XCTAssertEqual(n.description, "[[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]]")
        n += SnailfishNumber("[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]")
        XCTAssertEqual(n.description, "[[[[6,7],[6,7]],[[7,7],[0,7]]],[[[8,7],[7,7]],[[8,8],[8,0]]]]")
        n += SnailfishNumber("[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]")
        XCTAssertEqual(n.description, "[[[[7,0],[7,7]],[[7,7],[7,8]]],[[[7,7],[8,8]],[[7,7],[8,7]]]]")
        n += SnailfishNumber("[7,[5,[[3,8],[1,4]]]]")
        XCTAssertEqual(n.description, "[[[[7,7],[7,8]],[[9,5],[8,7]]],[[[6,8],[0,8]],[[9,9],[9,0]]]]")
        n += SnailfishNumber("[[2,[2,2]],[8,[8,1]]]")
        XCTAssertEqual(n.description, "[[[[6,6],[6,6]],[[6,0],[6,7]]],[[[7,7],[8,9]],[8,[8,1]]]]")
        n += SnailfishNumber("[2,9]")
        XCTAssertEqual(n.description, "[[[[6,6],[7,7]],[[0,7],[7,7]]],[[[5,5],[5,6]],9]]")
        n += SnailfishNumber("[1,[[[9,3],9],[[9,0],[0,7]]]]")
        XCTAssertEqual(n.description, "[[[[7,8],[6,7]],[[6,8],[0,8]]],[[[7,7],[5,0]],[[5,5],[5,6]]]]")
        n += SnailfishNumber("[[[5,[7,4]],7],1]")
        XCTAssertEqual(n.description, "[[[[7,7],[7,7]],[[8,7],[8,7]]],[[[7,0],[7,7]],9]]")
        n += SnailfishNumber("[[[[4,2],2],6],[8,7]]")
        XCTAssertEqual(n.description, "[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]")
    }

    let homeworkInput = """
    [[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
    [[[5,[2,8]],4],[5,[[9,9],0]]]
    [6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
    [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
    [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
    [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
    [[[[5,4],[7,7]],8],[[8,3],8]]
    [[9,3],[[9,9],[6,[4,9]]]]
    [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
    [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
    """.lines()

    func testExampleSumMagnitude() {
        let sum = SnailfishNumber.sum(homeworkInput)
        XCTAssertEqual(sum?.description, "[[[[6,6],[7,6]],[[7,7],[7,0]]],[[[7,7],[7,7]],[[7,8],[9,9]]]]")
        XCTAssertEqual(sum?.magnitude, 4140)
    }

    func testPart1() {
        XCTAssertEqual(day18_1(), 3665)
    }

    func testPart2Example() {
        XCTAssertEqual(SnailfishNumber.largestPairMagnitude(homeworkInput), 3993)
    }

    func testPart2() {
        XCTAssertEqual(day18_2(), 4775)
    }
}
