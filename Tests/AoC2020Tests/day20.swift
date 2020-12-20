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
        XCTAssertEqual(tile[.top], PixelRow("0011010010", radix: 2))
        XCTAssertEqual(tile[.bottom], PixelRow("0011100111", radix: 2))
        XCTAssertEqual(tile[.left], PixelRow("0111110010", radix: 2))
        XCTAssertEqual(tile[.right], PixelRow("0001011001", radix: 2))
    }

    func testReverseEdge() {
        let edge = PixelRow("0011010010", radix: 2)!
        XCTAssertEqual(edge.reversed(size: 10), PixelRow("0100101100", radix: 2))
    }

    func testPart1Example() {
        let input = Bundle.module.text(named: "day20example")
        XCTAssertEqual(cornerIdProduct(input), 20899048083289)
    }

    func testPart1() {
        XCTAssertEqual(day20_1(), 8581320593371)
    }

    func testPart2() {
        XCTAssertEqual(day20_2(), 0)
    }
}
