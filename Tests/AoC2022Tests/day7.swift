import XCTest
import AoC2022

final class Day7Tests: XCTestCase {

    let exampleInput = """
    $ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k
    """

    func testPart1Example() {
        XCTAssertEqual(smallDirectorySizes(node: buildFileSystem(exampleInput)), 95437)
    }

    func testPart1() {
        XCTAssertEqual(day7_1(), 1243729)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day7_2(), 0)
    }
}
