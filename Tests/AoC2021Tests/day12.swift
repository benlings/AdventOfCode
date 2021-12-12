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
    """.lines()

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
    """.lines()

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
    """.lines()

    func testPart1Example1() {
        let caves = CaveSystem(exampleInput1)
        let paths = caves.findPaths()
        XCTAssertEqual(paths.count, 10)
    }

    func testPart1Example2() {
        let caves = CaveSystem(exampleInput2)
        let paths = caves.findPaths()
        XCTAssertEqual(paths.count, 19)
    }

    func testPart1Example3() {
        let caves = CaveSystem(exampleInput3)
        let paths = caves.findPaths()
        XCTAssertEqual(paths.count, 226)
    }

    func testPart1() {
        XCTAssertEqual(day12_1(), 3421)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day12_2(), 0)
    }
}
