import XCTest
@testable import AoC2020

final class Day6Tests: XCTestCase {

    func testPart1SingleGroup() {
        let group = """
        abcx
        abcy
        abcz
        """
        XCTAssertEqual(count(groupAnswers: group), 6)
    }

    func testPart1MultipleGroups() {
        let groups = """
        abc

        a
        b
        c

        ab
        ac

        a
        a
        a
        a

        b
        """
        XCTAssertEqual(count(multipleGroupAnswers: groups), 11)
    }

    func testPart1() {
        XCTAssertEqual(day6_1(), 6726)
    }

    func testPart2() {
        XCTAssertEqual(day6_2(), 0)
    }
}
