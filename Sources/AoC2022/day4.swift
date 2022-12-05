import Foundation
import AdventCore

extension Scanner {
    func scanClosedRange() -> ClosedRange<Int>? {
        guard let lower = scanInt(),
              let _ = scanString("-"),
              let upper = scanInt() else {
            return nil
        }
        return lower...upper
    }
}

func parseRow(_ row: String) -> (ClosedRange<Int>, ClosedRange<Int>)? {
    let scanner = Scanner(string: row)
    guard let first = scanner.scanClosedRange(),
          let _ = scanner.scanString(","),
          let second = scanner.scanClosedRange() else {
        return nil
    }
    return (first, second)
}

public func countContainedSections(_ input: [String]) -> Int {
    input.compactMap(parseRow).count { sections in
        sections.0.contains(sections.1) || sections.1.contains(sections.0)
    }
}

public func countOverlappingSections(_ input: [String]) -> Int {
    input.compactMap(parseRow).count { sections in
        sections.0.overlaps(sections.1)
    }
}

fileprivate let day4_input = Bundle.module.text(named: "day4").lines()

public func day4_1() -> Int {
    countContainedSections(day4_input)
}

public func day4_2() -> Int {
    countOverlappingSections(day4_input)
}
