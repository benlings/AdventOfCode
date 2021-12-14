import XCTest
import AoC2021

final class Day14Tests: XCTestCase {

    let exampleInput = """
    NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C
    """

    func testPart1Example() {
        var poly = Polymerization(exampleInput)
        poly.step(count: 10)
        XCTAssertEqual(poly.elementsDifference(), 1588)
    }

    func testPart1() {
        XCTAssertEqual(day14_1(), 2988)
    }

    func testPart2Example() {
        var poly = Polymerization(exampleInput)
        poly.step(count: 40)
        XCTAssertEqual(poly.elementsDifference(), 2188189693529)
    }

    func testPart2() {
        XCTAssertEqual(day14_2(), 3572761917024)
    }
}
