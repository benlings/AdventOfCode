import Foundation
import AdventCore

func differences(_ input: String) -> [[Int]] {
  var numbers = input.split(separator: " ").compactMap { Int(String($0)) }
  var differences = [numbers]
  while !numbers.allSatisfy({ $0 == 0 }) {
    numbers = numbers.adjacentPairs().map { $0.1 - $0.0 }
    differences.append(numbers)
  }
  return differences
}

func propagate(_ differences: [[Int]]) -> Int {
  differences.compactMap(\.last).sum()
}

public func day9_1(_ input: String) -> Int {
  input
    .lines()
    .map {
      propagate(differences($0))
    }
    .sum()
}

public func day9_2(_ input: String) -> Int {
  0
}
