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
        XCTAssertEqual(circuit.signal(id: "d"), 72)
        XCTAssertEqual(circuit.signal(id: "e"), 507)
        XCTAssertEqual(circuit.signal(id: "f"), 492)
        XCTAssertEqual(circuit.signal(id: "g"), 114)
        XCTAssertEqual(circuit.signal(id: "h"), 65412)
        XCTAssertEqual(circuit.signal(id: "i"), 65079)
        XCTAssertEqual(circuit.signal(id: "x"), 123)
        XCTAssertEqual(circuit.signal(id: "y"), 456)
    }

    func testPart1() {
        XCTAssertEqual(day7_1(), 956)
    }

    func testPart2() {
        XCTAssertEqual(day7_2(), 40149)
    }
}
