import XCTest
import AoC2021

final class Day16Tests: XCTestCase {

    let exampleInput0 = "D2FE28"
    let exampleInput1 = "38006F45291200"
    let exampleInput2 = "EE00D40C823060"
    let exampleInput3 = "8A004A801A8002F478"
    let exampleInput4 = "620080001611562C8802118E34"
    let exampleInput5 = "C0015000016115A2E0802F182340"
    let exampleInput6 = "A0016C880162017C3686B18A3D4780"

    func testHexParsing() {
        XCTAssertEqual(String(Array(hex: exampleInput0).map(\.rawValue)), "110100101111111000101000")
    }

    func testPart1Example() {
        let packet = Packet(binary: Array(hex: exampleInput0))
        XCTAssertEqual(packet.version, 6)
        XCTAssertEqual(packet.contents, .literal(2021))
        XCTAssertEqual(Packet(binary: Array(hex: exampleInput3)).versionSum, 16)
        XCTAssertEqual(Packet(binary: Array(hex: exampleInput4)).versionSum, 12)
        XCTAssertEqual(Packet(binary: Array(hex: exampleInput5)).versionSum, 23)
        XCTAssertEqual(Packet(binary: Array(hex: exampleInput6)).versionSum, 31)
    }

    func testPart1() {
        XCTAssertEqual(day16_1(), 979)
    }

    func testPart2Example() {
        XCTAssertEqual(0, 0)
    }

    func testPart2() {
        XCTAssertEqual(day16_2(), 277110354175)
    }
}
