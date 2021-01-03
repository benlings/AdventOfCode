import XCTest
import AoC2015

final class Day5Tests: XCTestCase {

    func testPart1Examples() {
        XCTAssertEqual(isNicePart1("ugknbfddgicrmopn"), true)
        XCTAssertEqual(isNicePart1("aaa"), true)
        XCTAssertEqual(isNicePart1("jchzalrnumimnmhp"), false)
        XCTAssertEqual(isNicePart1("haegwjzuvuyypxyu"), false)
        XCTAssertEqual(isNicePart1("dvszwmarrgswjxmb"), false)
    }

    func testPart1() {
        XCTAssertEqual(day5_1(), 255)
    }

    func testPart2Examples() {
        XCTAssertEqual(isNicePart2("qjhvhtzxzqqjkmpb"), true)
        XCTAssertEqual(isNicePart2("xxyxx"), true)
        XCTAssertEqual(isNicePart2("uurcxstgmygtbstg"), false)
        XCTAssertEqual(isNicePart2("ieodomkazucvgmuy"), false)
    }

    func testPart2() {
        XCTAssertEqual(day5_2(), 55)
    }
}
