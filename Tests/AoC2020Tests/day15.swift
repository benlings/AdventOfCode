import XCTest
import AoC2020

final class Day15Tests: XCTestCase {

    func testPart1Examples() {
        XCTAssertEqual(MemoryGame("0,3,6").numberAt(2020), 436)
        XCTAssertEqual(MemoryGame("1,3,2").numberAt(2020), 1)
        XCTAssertEqual(MemoryGame("2,1,3").numberAt(2020), 10)
        XCTAssertEqual(MemoryGame("1,2,3").numberAt(2020), 27)
        XCTAssertEqual(MemoryGame("2,3,1").numberAt(2020), 78)
        XCTAssertEqual(MemoryGame("3,2,1").numberAt(2020), 438)
        XCTAssertEqual(MemoryGame("3,1,2").numberAt(2020), 1836)
    }

    func testPart1() {
        XCTAssertEqual(day15_1(), 1696)
    }

    func testPart2Examples() {
        XCTAssertEqual(MemoryGame("0,3,6").numberAt(30000000), 175594)
        // Commented out because they take 2 seconds each...
//        XCTAssertEqual(MemoryGame("1,3,2").numberAt(30000000), 2578)
//        XCTAssertEqual(MemoryGame("2,1,3").numberAt(30000000), 3544142)
//        XCTAssertEqual(MemoryGame("1,2,3").numberAt(30000000), 261214)
//        XCTAssertEqual(MemoryGame("2,3,1").numberAt(30000000), 6895259)
//        XCTAssertEqual(MemoryGame("3,2,1").numberAt(30000000), 18)
//        XCTAssertEqual(MemoryGame("3,1,2").numberAt(30000000), 362)
    }

    func testPart2() {
        XCTAssertEqual(day15_2(), 37385)
    }
}
