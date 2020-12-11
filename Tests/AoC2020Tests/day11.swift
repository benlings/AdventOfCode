import XCTest
@testable import AoC2020

final class Day11Tests: XCTestCase {

    func testPart1Example() {
        let input = """
        L.LL.LL.LL
        LLLLLLL.LL
        L.L.L..L..
        LLLL.LL.LL
        L.LL.LL.LL
        L.LLLLL.LL
        ..L.L.....
        LLLLLLLLLL
        L.LLLLLL.L
        L.LLLLL.LL
        """
        var waitingArea = WaitingArea(input)
        XCTAssertEqual(waitingArea.description, input)
        waitingArea.step()
        XCTAssertEqual(waitingArea.description, """
            #.##.##.##
            #######.##
            #.#.#..#..
            ####.##.##
            #.##.##.##
            #.#####.##
            ..#.#.....
            ##########
            #.######.#
            #.#####.##
            """)

        waitingArea.findSteadyState()
        XCTAssertEqual(waitingArea.description, """
            #.#L.L#.##
            #LLL#LL.L#
            L.#.L..#..
            #L##.##.L#
            #.#L.LL.LL
            #.#L#L#.##
            ..L.L.....
            #L#L##L#L#
            #.LLLLLL.L
            #.#L#L#.##
            """)
        XCTAssertEqual(waitingArea.occupied, 37)
    }

    func testPart1() {
        XCTAssertEqual(day11_1(), 2441)
    }

    func testPart2Example() {
        let input = """
        L.LL.LL.LL
        LLLLLLL.LL
        L.L.L..L..
        LLLL.LL.LL
        L.LL.LL.LL
        L.LLLLL.LL
        ..L.L.....
        LLLLLLLLLL
        L.LLLLLL.L
        L.LLLLL.LL
        """
        var waitingArea = WaitingArea(input)
        waitingArea.step(strategy: .visible)
        XCTAssertEqual(waitingArea.description, """
            #.##.##.##
            #######.##
            #.#.#..#..
            ####.##.##
            #.##.##.##
            #.#####.##
            ..#.#.....
            ##########
            #.######.#
            #.#####.##
            """)
        waitingArea.step(strategy: .visible)
        XCTAssertEqual(waitingArea.description, """
            #.LL.LL.L#
            #LLLLLL.LL
            L.L.L..L..
            LLLL.LL.LL
            L.LL.LL.LL
            L.LLLLL.LL
            ..L.L.....
            LLLLLLLLL#
            #.LLLLLL.L
            #.LLLLL.L#
            """)
        waitingArea.findSteadyState(strategy: .visible)
        XCTAssertEqual(waitingArea.description, """
            #.L#.L#.L#
            #LLLLLL.LL
            L.L.L..#..
            ##L#.#L.L#
            L.L#.LL.L#
            #.LLLL#.LL
            ..#.L.....
            LLL###LLL#
            #.LLLLL#.L
            #.L#LL#.L#
            """)
        XCTAssertEqual(waitingArea.occupied, 26)

    }

    func testPart2() {
        XCTAssertEqual(day11_2(), 0)
    }
}
