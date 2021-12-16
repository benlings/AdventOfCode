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

    func testPart1Example()
    {
        let report = SubmarineDiagnostic(exampleInput)
        XCTAssertEqual(report.gammaRate(), Int("10110", radix: 2))
        XCTAssertEqual(report.epsilonRate(), Int("01001", radix: 2))
        XCTAssertEqual(report.powerConsumption(), 198)
    }

    func testPart1() {
        XCTAssertEqual(day3_1(), 3687446)
    }

    func testPart2Example()
    {
        let report = SubmarineDiagnostic(exampleInput)
        XCTAssertEqual(report.co2ScrubberRating(), Int("01010", radix: 2))
        XCTAssertEqual(report.oxygenGeneratorRating(), Int("10111", radix: 2))
        XCTAssertEqual(report.lifeSupportRating(), 230)
    }

    func testPart2() {
        XCTAssertEqual(day3_2(), 4406844)
    }
}
