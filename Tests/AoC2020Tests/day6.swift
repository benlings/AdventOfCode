import XCTest
@testable import AoC2020

final class Day6Tests: XCTestCase {

    func testPart1SingleGroup() {
        let group = """
        abcx
        abcy
        abcz
        """
        XCTAssertEqual(countAnyoneAnswers(groupAnswers: group), 6)
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
        XCTAssertEqual(countGroups(multipleGroupAnswers: groups, groupCount: countAnyoneAnswers(groupAnswers:)), 11)
    }

    func testPart1() {
        XCTAssertEqual(day6_1(), 6726)
    }

    func testPart2SingleGroup() {
        let group = """
        abcx
        abcy
        abcz
        """
        XCTAssertEqual(countEveryoneAnswers(groupAnswers: group), 3)
    }

    func testPart2MultipleGroups() {
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
        XCTAssertEqual(countGroups(multipleGroupAnswers: groups, groupCount: countEveryoneAnswers(groupAnswers:)), 6)
    }

    func testPart2() {
        XCTAssertEqual(day6_2(), 3316)
    }
}
