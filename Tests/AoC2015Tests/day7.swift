import XCTest
import AoC2015

final class Day7Tests: XCTestCase {

    func testPart1Example() {
        let input = """
        123 -> x
        456 -> y
        x AND y -> d
        x OR y -> e
        x LSHIFT 2 -> f
        y RSHIFT 2 -> g
        NOT x -> h
        NOT y -> i
        """
        var circuit = Circuit(input)
        XCTAssertEqual(circuit["d"], 72)
        XCTAssertEqual(circuit["e"], 507)
        XCTAssertEqual(circuit["f"], 492)
        XCTAssertEqual(circuit["g"], 114)
        XCTAssertEqual(circuit["h"], 65412)
        XCTAssertEqual(circuit["i"], 65079)
        XCTAssertEqual(circuit["x"], 123)
        XCTAssertEqual(circuit["y"], 456)
    }

    func testPart1() {
        XCTAssertEqual(day7_1(), 956)
    }

    func testPart2() {
        XCTAssertEqual(day7_2(), 40149)
    }
}
