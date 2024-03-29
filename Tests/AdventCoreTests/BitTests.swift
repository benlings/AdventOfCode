import XCTest
import AdventCore

final class BitTests: XCTestCase {

    func testBinaryToInt()
    {
        XCTAssertEqual([Bit.on, .off, .on, .on, .off].toInt(), 22)
        XCTAssertEqual([Bit.off, .on, .off, .off, .on].toInt(), 9)
    }

    func testHexParsing() {
        XCTAssertEqual(Array(hex: "D2FE28").rawJoined(), "110100101111111000101000")
    }

}
