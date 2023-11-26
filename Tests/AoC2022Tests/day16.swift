import XCTest
import AoC2022

final class Day16Tests: XCTestCase {

    let input = Bundle.module.text(named: "day16").lines()

    let exampleInput = """
    Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
    Valve BB has flow rate=13; tunnels lead to valves CC, AA
    Valve CC has flow rate=2; tunnels lead to valves DD, BB
    Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
    Valve EE has flow rate=3; tunnels lead to valves FF, DD
    Valve FF has flow rate=0; tunnels lead to valves EE, GG
    Valve GG has flow rate=0; tunnels lead to valves FF, HH
    Valve HH has flow rate=22; tunnel leads to valve GG
    Valve II has flow rate=0; tunnels lead to valves AA, JJ
    Valve JJ has flow rate=21; tunnel leads to valve II
    """.lines()

    func testPart1Example() {
        XCTAssertEqual(day16_1(exampleInput), 1651)
    }

    func testPart1() {
        XCTAssertEqual(day16_1(input), 2181)
    }

    func testPart2Example() {
        XCTAssertEqual(day16_2(exampleInput), 1707)
    }

    func testPart2() {
        XCTAssertEqual(day16_2(input), 0)
    }
}
