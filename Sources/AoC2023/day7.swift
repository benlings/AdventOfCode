import Foundation
import AdventCore

//  Five of a kind, where all five cards have the same label: AAAAA
//  Four of a kind, where four cards have the same label and one card has a different label: AA8AA
//  Full house, where three cards have the same label, and the remaining two cards share a different label: 23332
//  Three of a kind, where three cards have the same label, and the remaining two cards are each different from any other card in the hand: TTT98
//  Two pair, where two cards share one label, two other cards share a second label, and the remaining card has a third label: 23432
//  One pair, where two cards share one label, and the other three cards have a different label from the pair and each other: A23A4
//  High card, where all cards' labels are distinct: 23456

enum HandType: Comparable {
  case highCard
  case onePair
  case twoPair
  case threeOfAKind
  case fullHouse
  case fourOfAKind
  case fiveOfAKind

  init(cards: [Hand.Card], isJoker: Bool) {
    assert(cards.count == 5)
    var counts = cards.grouped(by: { $0 }).mapValues(\.count)
    if isJoker,
       let jokerCount = counts[.joker],
       let maxKey = (counts.filter { $0.key != .joker }).max(on: \.value)?.key {
      // Move joker to card we already have the most of
      counts[.joker] = nil
      counts[maxKey, default: 0] += jokerCount
    }
    switch counts.count {
    case 1:
      self = .fiveOfAKind
    case 2:
      if counts.values.contains(where: { $0 == 4 }) {
        self = .fourOfAKind
      } else {
        self = .fullHouse
      }
    case 3:
      if counts.values.contains(where: { $0 == 3 }) {
        self = .threeOfAKind
      } else {
        self = .twoPair
      }
    case 4:
      self = .onePair
    case 5:
      self = .highCard
    default:
      fatalError()
    }
  }
}

struct Hand {

  enum Card: Character {
    case ace = "A"
    case king = "K"
    case queen = "Q"
    case jack = "J"
    case ten = "T"
    case nine = "9"
    case eight = "8"
    case seven = "7"
    case six = "6"
    case five = "5"
    case four = "4"
    case three = "3"
    case two = "2"

    static let joker: Card = .jack

    var jackRank: Int {
      switch self {
      case .ace: 13
      case .king: 12
      case .queen: 11
      case .jack: 10
      case .ten: 9
      case .nine: 8
      case .eight: 7
      case .seven: 6
      case .six: 5
      case .five: 4
      case .four: 3
      case .three: 2
      case .two: 1
      }
    }

    var jokerRank: Int {
      switch self {
      case .ace: 13
      case .king: 12
      case .queen: 11
      case .ten: 9
      case .nine: 8
      case .eight: 7
      case .seven: 6
      case .six: 5
      case .five: 4
      case .four: 3
      case .three: 2
      case .two: 1
      case .jack: 0
      }
    }
  }

  var cards: [Card]
  var type: HandType
  var jokerType: HandType

  var bid: Int

  init(cards: [Card], bid: Int) {
    assert(cards.count == 5)
    self.cards = cards
    self.type = HandType(cards: cards, isJoker: false)
    self.jokerType = HandType(cards: cards, isJoker: true)
    self.bid = bid
  }

  static func totalWinnings(_ input: String, handType: (Hand) -> HandType, cardRank: (Card) -> Int) -> Int {
    input
      .lines()
      .compactMap(Hand.init)
      .sorted { lhs, rhs in
        if handType(lhs) == handType(rhs) {
          return lhs.cards.lexicographicallyPrecedes(rhs.cards, on: cardRank)
        }
        return handType(lhs) < handType(rhs)
      }
      .enumerated()
      .map { (index, hand) in (index + 1) * hand.bid }
      .sum()
  }
}

extension Hand {
  init?(_ description: String) {
    let scanner = Scanner(string: description)
    guard let cards = scanner.scanUpToCharacters(from: .whitespaces),
          let bid = scanner.scanInt()
    else { return nil }
    self = Hand(cards: cards.compactMap(Hand.Card.init), bid: bid)
  }
}

public func day7_1(_ input: String) -> Int {
  Hand.totalWinnings(input, handType: \.type, cardRank: \.jackRank)
}

public func day7_2(_ input: String) -> Int {
  Hand.totalWinnings(input, handType: \.jokerType, cardRank: \.jokerRank)
}
