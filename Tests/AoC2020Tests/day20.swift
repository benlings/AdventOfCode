import XCTest
import AoC2020
import Foundation

final class Day20Tests: XCTestCase {

    func testParseTile() {
        let input = """
        Tile 2311:
        ..##.#..#.
        ##..#.....
        #...##..#.
        ####.#...#
        ##.##.###.
        ##...#.###
        .#.#.#..##
        ..#....#..
        ###...#.#.
        ..###..###
        """
        let tile = CameraTile(input)
        XCTAssertEqual(tile.id, 2311)
        XCTAssertEqual(tile.size, 10)
        XCTAssertEqual(tile[.top], EdgeId("0011010010", radix: 2))
        XCTAssertEqual(tile[.bottom], EdgeId("1110011100", radix: 2))
        XCTAssertEqual(tile[.left], EdgeId("0100111110", radix: 2))
        XCTAssertEqual(tile[.right], EdgeId("0001011001", radix: 2))
    }

    func testReverseEdge() {
        let edge = EdgeId("0011010010", radix: 2)!
        XCTAssertEqual(edge.reversed(size: 10), EdgeId("0100101100", radix: 2))
    }

    func testPart1Example() {
        let input = Bundle.module.text(named: "day20example")
        XCTAssertEqual(TiledImage(input).cornerIdProduct(), 20899048083289)
    }

    func testPart1() {
        XCTAssertEqual(day20_1(), 8581320593371)
    }

    func testPart2() {
        XCTAssertEqual(day20_2(), 0)
    }
}
