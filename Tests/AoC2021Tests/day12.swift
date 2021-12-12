import XCTest
import AoC2021

final class Day12Tests: XCTestCase {

    let exampleInput1 = """
    start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end
    """

    let exampleInput2 = """
    dc-end
    HN-start
    start-kj
    dc-start
    dc-HN
    LN-dc
    HN-end
    kj-sa
    kj-HN
    kj-dc
    """

    let exampleInput3 = """
    fs-end
    he-DX
    fs-he
    start-DX
    pj-DX
    end-zg
    zg-sl
    zg-pj
    pj-he
    RW-he
    fs-DX
    pj-RW
    zg-RW
    start-pj
    he-WI
    zg-he
    pj-fs
    start-RW
    """

    func testPart1Example1() {
        XCTAssertEqual(CaveSystem.countPaths(exampleInput1), 10)
    }

    func testPart1Example2() {
        XCTAssertEqual(CaveSystem.countPaths(exampleInput2), 19)
    }

    func testPart1Example3() {
        XCTAssertEqual(CaveSystem.countPaths(exampleInput3), 226)
    }

    func testPart1() {
        XCTAssertEqual(day12_1(), 3421)
    }

    func testPart2Example1() {
        XCTAssertEqual(CaveSystem.countRevisitingPaths(exampleInput1), 36)
    }

    func testPart2Example2() {
        XCTAssertEqual(CaveSystem.countRevisitingPaths(exampleInput2), 103)
    }

    func testPart2Example3() {
        XCTAssertEqual(CaveSystem.countRevisitingPaths(exampleInput3), 3509)
    }

    func testPart2() {
        XCTAssertEqual(day12_2(), 84870)
    }
}
