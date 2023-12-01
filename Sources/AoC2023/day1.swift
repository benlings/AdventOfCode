import Foundation
import AdventCore

func calibrationValue(_ line: String) -> Int? {
  guard let first = line.first(where: \.isNumber),
        let last = line.last(where: \.isNumber) else { return nil }
  return Int(String([first, last]))
}

let digitValues = [
  "1": 1,
  "2": 2,
  "3": 3,
  "4": 4,
  "5": 5,
  "6": 6,
  "7": 7,
  "8": 8,
  "9": 9,
  "one": 1,
  "two": 2,
  "three": 3,
  "four": 4,
  "five": 5,
  "six": 6,
  "seven": 7,
  "eight": 8,
  "nine": 9,
]

let digitRegex = try! Regex("\(digitValues.keys.joined(separator: "|"))", as: Substring.self)
let reverseDigitRegex = try! Regex("\(String(digitValues.keys.map { $0.reversed() }.joined(separator: "|")))", as: Substring.self)

func calibrationValue2(_ line: String) -> Int? {
  if let firstD = line.firstMatch(of: digitRegex)?.output,
     let firstN = digitValues[String(firstD)],
     let lastD = String(line.reversed()).firstMatch(of: reverseDigitRegex)?.output,
     let lastN = digitValues[String(lastD.reversed())] {
    return firstN * 10 + lastN
  }
  return nil
}

public func day1_1(_ input: String) -> Int {
  input
    .lines()
    .compactMap(calibrationValue)
    .sum()
}

public func day1_2(_ input: String) -> Int {
  input
    .lines()
    .compactMap(calibrationValue2)
    .sum()
}
