import Foundation
import AdventCore

func calcHash(_ s: Substring) -> Int {
  var hash = 0
  for c in s {
    if let i = c.asciiValue {
      hash += Int(i)
      hash *= 17
      hash %= 256
    }
  }
  return hash
}

public func day15_1(_ input: String) -> Int {
  input.trimmingCharacters(in: .newlines).split(separator: ",").map(calcHash).sum()
}

public func day15_2(_ input: String) -> Int {
  0
}
