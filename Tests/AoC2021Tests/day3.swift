import XCTest
import AoC2021

final class Day3Tests: XCTestCase {

    let exampleInput = """
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
    """

    func testBinaryToInt()
    {
        XCTAssertEqual(toInt(binary: [1,0,1,1,0]), 22)
        XCTAssertEqual(toInt(binary: [0,1,0,0,1]), 9)
    }

    func testPart1Example()
    {
        let report = SubmarineDiagnostic(exampleInput)
        XCTAssertEqual(report.gammaRate(), [1,0,1,1,0])
        XCTAssertEqual(report.epsilonRate(), [0,1,0,0,1])
        XCTAssertEqual(report.powerConsumption(), 198)
    }

    func testPart1() {
        XCTAssertEqual(day3_1(), 3687446)
    }

    func testPart2() {
        XCTAssertEqual(day3_2(), 0)
    }
}
