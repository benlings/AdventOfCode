import Foundation
import AdventCore

struct ScratchCard {
  var id: Int
  var winningNumbers: Set<Int>
  var numbersYouHave: Set<Int>

  var matchCount: Int {
    self.winningNumbers.intersection(numbersYouHave).count
  }

  var points: Int {
    let c = matchCount
    return c > 0 ? 1 << (c - 1) : 0
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
  let cards = input
    .lines()
    .compactMap { line in
      ScratchCard(line)
    }
  var cardCounts = Array(repeating: 1, count: cards.count)
  for card in cards {
    let repetitions = cardCounts[card.id - 1]
    for i in 0..<card.matchCount {
      let wonCardId = card.id + i + 1
      guard wonCardId <= cardCounts.count else { break }
      cardCounts[wonCardId - 1] += repetitions
    }
  }
  return cardCounts.sum()
}
