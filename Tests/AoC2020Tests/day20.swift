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
        XCTAssertEqual(tile[.bottom], EdgeId("0011100111", radix: 2))
        XCTAssertEqual(tile[.left], EdgeId("0111110010", radix: 2))
        XCTAssertEqual(tile[.right], EdgeId("0001011001", radix: 2))
    }

    func testReverseEdge() {
        let edge = EdgeId("0011010010", radix: 2)!
        XCTAssertEqual(edge.reversed(size: 10), EdgeId("0100101100", radix: 2))
    }

    let exampleImage = TiledImage(Bundle.module.text(named: "day20example"))

    func testPart1Example() {
        XCTAssertEqual(exampleImage.cornerIdProduct(), 20899048083289)
    }

    func testPart1() {
        XCTAssertEqual(day20_1(), 8581320593371)
    }

    func testPart2Example() {
        XCTAssertEqual(exampleImage.mergeTiles().description, """
            ...###...##...#...#..###
            .#.###..##..##..####.##.
            #.##..#..#...#..####...#
            #####..#####...###....##
            #..####...#.#.#.###.###.
            ..#.#..#..#.#.#.####.###
            .####.###.#...###.#..#.#
            .#.#.###.##.##.#..#.##..
            ###.#...#..#.##.######..
            .#.#....#.##.#...###.##.
            ...#..#..#.#.##..###.###
            ##..##.#...#...#.#.#.#..
            #.####....##..########.#
            ###.#.#...#.######.#..##
            #.####..#.####.#.#.###..
            #..#.##..#..###.#.##....
            .####...#..#.....#......
            ....#..#...##..#.#.###..
            ...########.#....#####.#
            ##.#....#.##.####...#.##
            ###.#####...#.#####.#..#
            ##.##.###.#.#..######...
            ###....#.#....#..#......
            .#.#..#.##...#.##..#####
            """)
        XCTAssertEqual(CameraImage.seaMonster.description, """
            ..................#.
            #....##....##....###
            .#..#..#..#..#..#...
            """)
        XCTAssertEqual(exampleImage.findSeaMonsters().1.count, 2)
        XCTAssertEqual(exampleImage.waterRoughness(), 273)
    }

    func testPart2() {
        XCTAssertEqual(day20_2(), 2031)
    }
}
