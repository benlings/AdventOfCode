import XCTest
import AoC2020

final class Day25Tests: XCTestCase {

    func testPart1Example() {
        let input = """
        5764801
        17807724
        """
        XCTAssertEqual(HotelCypher(input).findEncryptionKey(), 14897079)
    }

    func testPart1() {
        XCTAssertEqual(day25_1(), 10548634)
    }

    func testPart2() {
        XCTAssertEqual(day25_2(), 0)
    }
}
