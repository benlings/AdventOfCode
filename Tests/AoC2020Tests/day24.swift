import XCTest
import AoC2020

final class Day24Tests: XCTestCase {

    let example = TiledFloor("""
        sesenwnenenewseeswwswswwnenewsewsw
        neeenesenwnwwswnenewnwwsewnenwseswesw
        seswneswswsenwwnwse
        nwnwneseeswswnenewneswwnewseswneseene
        swweswneswnenwsewnwneneseenw
        eesenwseswswnenwswnwnwsewwnwsene
        sewnenenenesenwsewnenwwwse
        wenwwweseeeweswwwnwwe
        wsweesenenewnwwnwsenewsenwwsesesenwne
        neeswseenwwswnwswswnw
        nenwswwsewswnenenewsenwsenwnesesenew
        enewnwewneswsewnwswenweswnenwsenwsw
        sweneswneswneneenwnewenewwneswswnese
        swwesenesewenwneswnwwneseswwne
        enesenwswwswneneswsenwnewswseenwsese
        wnwnesenesenenwwnenwsewesewsesesew
        nenewswnwewswnenesenwnesewesw
        eneswnwswnwsenenwnwnwwseeswneewsenese
        neswnwewnwnwseenwseesewsenwsweewe
        wseweeenwnesenwwwswnew
        """)

    func testPart1Example() {
        XCTAssertEqual(example.countBlack(), 10)
    }

    func testPart1() {
        XCTAssertEqual(day24_1(), 332)
    }

    func testPart2Example() {
        XCTAssertEqual(example.run(days: 1), 15)
        XCTAssertEqual(example.run(days: 10), 37)
        XCTAssertEqual(example.run(days: 100), 2208)
    }

    func testPart2() {
        XCTAssertEqual(day24_2(), 3900)
    }
}
