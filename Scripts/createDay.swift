#!/usr/bin/swift

import Foundation

let year = CommandLine.arguments[1]
let day = CommandLine.arguments[2]

print("Creating files for AoC \(year), day \(day)")

let source = """
import Foundation
import AdventCore

public func day\(day)_1() -> Int {
    0
}

public func day\(day)_2() -> Int {
    0
}
"""

let tests = """
import XCTest
import AoC\(year)

final class Day\(day)Tests: XCTestCase {

    func testPart1() {
        XCTAssertEqual(day\(day)_1(), 0)
    }

    func testPart2() {
        XCTAssertEqual(day\(day)_2(), 0)
    }
}
"""

let sourceURL = URL(fileURLWithPath: "Sources/AoC\(year)/day\(day).swift")
let testURL = URL(fileURLWithPath: "Tests/AoC\(year)Tests/day\(day).swift")
let inputURL = URL(fileURLWithPath: "Sources/AoC\(year)/Resources/day\(day).txt")

try? source.write(to: sourceURL, atomically: true, encoding: .utf8)
try? tests.write(to: testURL, atomically: true, encoding: .utf8)
try? "".write(to: inputURL, atomically: true, encoding: .utf8)

