#!/usr/bin/swift

import Foundation

let year = CommandLine.arguments[1]
let day = CommandLine.arguments[2]

print("Creating files for AoC \(year), day \(day)")

let source = """
import Foundation
import AdventCore

public func day\(day)_1(_ input: String) -> Int {
    0
}

public func day\(day)_2(_ intput: String) -> Int {
    0
}
"""

let tests = #"""
import XCTest
import AoC\#(year)

final class Day\#(day)Tests: XCTestCase {

    let input = Bundle.module.text(named: "day\#(day)")

    let exampleInput = """
    """

    func testPart1Example() {
        XCTAssertEqual(day\#(day)_1(exampleInput), 0)
    }

    func testPart1() {
        XCTAssertEqual(day\#(day)_1(input), 0)
    }

    func testPart2Example() {
        XCTAssertEqual(day\#(day)_2(exampleInput), 0)
    }

    func testPart2() {
        XCTAssertEqual(day\#(day)_2(input), 0)
    }
}
"""#

let sourceURL = URL(fileURLWithPath: "Sources/AoC\(year)/day\(day).swift")
let testURL = URL(fileURLWithPath: "Tests/AoC\(year)Tests/day\(day).swift")
let inputURL = URL(fileURLWithPath: "Tests/AoC\(year)Tests/Resources/day\(day).txt")

func create(contents: String, url: URL) throws {
    try? FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
    try contents.write(to: url, atomically: true, encoding: .utf8)
}

try? create(contents: source, url: sourceURL)
try? create(contents: tests, url: testURL)
try? create(contents: "", url: inputURL)
