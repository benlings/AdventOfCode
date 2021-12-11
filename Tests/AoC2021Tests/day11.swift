import XCTest
import AoC2021

final class Day11Tests: XCTestCase {

    let exampleInput = """
    5483143223
    2745854711
    5264556173
    6141336146
    6357385478
    4167524645
    2176841721
    6882881134
    4846848554
    5283751526
    """

    func testPart1Example() {
        var levels = EnergyLevels(exampleInput)
        levels.step()
        XCTAssertEqual(levels.description, """
        6594254334
        3856965822
        6375667284
        7252447257
        7468496589
        5278635756
        3287952832
        7993992245
        5957959665
        6394862637
        """)
        XCTAssertEqual(levels.flashes, 0)
        levels.step()
        XCTAssertEqual(levels.description, """
        8807476555
        5089087054
        8597889608
        8485769600
        8700908800
        6600088989
        6800005943
        0000007456
        9000000876
        8700006848
        """)
        XCTAssertEqual(levels.flashes, 35)
    }

    func testPart1() {
        XCTAssertEqual(day11_1(), 1793)
    }

    func testPart2Example() {
        var levels = EnergyLevels(exampleInput)
        levels.iterateUntilSynchronsed()
        XCTAssertEqual(levels.stepCount, 195)
    }

    func testPart2() {
        XCTAssertEqual(day11_2(), 247)
    }
}
