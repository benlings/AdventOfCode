import Foundation
import AdventCore

struct ScratchCard {
  var id: Int
  var winningNumbers: Set<Int>
  var numbersYouHave: Set<Int>

  var points: Int {
    let winningNumbersCount = self.winningNumbers.intersection(numbersYouHave).count
    return winningNumbersCount > 0 ? 1 << (winningNumbersCount - 1) : 0
  }

}

extension Scanner {

  func scanInts() -> [Int] {
    var ints = [Int]()
    while !isAtEnd, let num = scanInt() {
      ints.append(num)
    }
    return ints
  }

  func scanScratchCard() -> ScratchCard? {
    guard let _ = scanString("Card"),
          let id = scanInt(),
          let _ = scanString(":"),
          case let winning = scanInts(),
          let _ = scanString("|"),
          case let have = scanInts()
    else { return nil }
    return ScratchCard(id: id, winningNumbers: Set(winning), numbersYouHave: Set(have))
  }
}

extension ScratchCard {
  init?(_ description: String) {
    let scanner = Scanner(string: description)
    if let card = scanner.scanScratchCard() {
      self = card
    } else {
      return nil
    }
  }
}

public func day4_1(_ input: String) -> Int {
  input.lines().compactMap { ScratchCard($0)?.points }.sum()
}

public func day4_2(_ input: String) -> Int {
  0
}
