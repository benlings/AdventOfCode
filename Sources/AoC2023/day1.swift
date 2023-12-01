import Foundation
import AdventCore

func calibrationValue(_ line: String) -> Int? {
  let digits = line.filter(\.isNumber)
  guard let first = digits.first,
        let last = digits.last else { return nil }
  return Int(String([first, last]))
}

public func day1_1(_ input: String) -> Int {
  input
    .lines()
    .compactMap(calibrationValue)
    .sum()
}

public func day1_2(_ intput: String) -> Int {
    0
}
