import Foundation
import AdventCore

enum Direction: Character {
  case left = "L"
  case right = "R"
  func pick(_ nodes: (left: Network.ID, right: Network.ID)) -> Network.ID {
    switch self {
    case .left: nodes.left
    case .right: nodes.right
    }
  }
}

struct Network {
  typealias ID = String
  var instructions: [Direction]
  var nodes: [ID: (left: ID, right: ID)]
  static let start: ID = "AAA"
  static let end: ID = "ZZZ"

  func countSteps() -> Int {
    var count = 0
    var node = Self.start
    for instruction in instructions.cycled() {
      if node == Self.end {
        break
      }
      node = instruction.pick(nodes[node]!)
      count += 1
    }
    return count
  }
}

extension Scanner {
  func scanNetworkNode() -> (start: Network.ID, end: (left: Network.ID, right: Network.ID))? {
    guard let start = scanUpToCharacters(from: .whitespaces),
          let _ = scanString("= ("),
          let left = scanUpToString(","),
          let _ = scanString(","),
          let right = scanUpToString(")"),
          let _ = scanString(")")
    else { return nil }
    return (start, (left, right))
  }
}

extension Network {
  init(_ description: String) {
    let groups = description.groups()
    self.instructions = groups[0].compactMap(Direction.init)
    self.nodes = [:]
    let scanner = Scanner(string: groups[1])
    while !scanner.isAtEnd, let node = scanner.scanNetworkNode() {
      self.nodes[node.start] = node.end
    }
  }
}

public func day8_1(_ input: String) -> Int {
  let network = Network(input)
  return network.countSteps()
}

public func day8_2(_ input: String) -> Int {
  0
}
