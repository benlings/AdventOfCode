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
        XCTAssertEqual(tile.topEdge, PixelRow("0011010010", radix: 2))
        XCTAssertEqual(tile.bottomEdge, PixelRow("0011100111", radix: 2))
        XCTAssertEqual(tile.leftEdge, PixelRow("0111110010", radix: 2))
        XCTAssertEqual(tile.rightEdge, PixelRow("0001011001", radix: 2))
    }

    func testPart1Example() {
//        let input = Bundle.module.text(named: "day20example")
        
    }

    func testPart1() {
        XCTAssertEqual(day20_1(), 0)
    }

    func testPart2() {
        XCTAssertEqual(day20_2(), 0)
    }
}
