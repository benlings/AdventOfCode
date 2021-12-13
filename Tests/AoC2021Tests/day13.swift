import XCTest
import AoC2021

final class Day13Tests: XCTestCase {

    let exampleInput = """
    6,10
    0,14
    9,10
    0,3
    10,4
    4,11
    6,0
    6,12
    4,1
    0,13
    10,12
    3,4
    3,0
    8,4
    1,10
    2,14
    8,10
    9,0

    fold along y=7
    fold along x=5
    """

    func testPart1Example() {
        XCTAssertEqual(TransparentPaper.visibleDotsAfterFirstFold(exampleInput), 17)
    }

    func testPart1() {
        XCTAssertEqual(day13_1(), 687)
    }

    func testPart2Example() {
        let _ = TransparentPaper.patternAfterFolds(exampleInput)
        XCTAssertEqual("O", "O")
    }

    func testPart2() {
        XCTAssertEqual(day13_2(), "FGKCKBZG")
    }
}
