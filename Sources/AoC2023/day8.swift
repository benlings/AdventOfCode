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

  var ghostStartNodes: [ID] {
    nodes.keys.filter { $0.hasSuffix("A") }
  }

  func isGhostEndNode(_ node: ID) -> Bool {
    node.hasSuffix("Z")
  }

  func countSteps(start: ID = Self.start, isEnd: (ID) -> Bool = { $0 == Self.end }) -> Int {
    var count = 0
    var node = start
    for instruction in instructions.cycled() {
      if isEnd(node) {
        break
      }
      node = instruction.pick(nodes[node]!)
      count += 1
    }
    return count
  }

  func countGhostSteps() -> Int {
    let cycleLengths = ghostStartNodes.map {
      countSteps(start: $0, isEnd: isGhostEndNode)
    }
    return cycleLengths.lcm()!
  }

  func analyseGhostSteps() {
    var count = 0
    var nodes = ghostStartNodes
    for (i, instruction) in instructions.indexed().cycled() {
      if nodes.allSatisfy(isGhostEndNode) {
        break
      }
      if nodes.contains(where: { $0.hasSuffix("Z") || $0.hasSuffix("A") }) {
        print("\(count) (\(i)): \(nodes.map { $0.hasSuffix("Z") ? "e" : $0.hasSuffix("A") ? "s" : "." }.joined(separator: ", "))")
      }
      nodes = nodes.map { instruction.pick(self.nodes[$0]!) }
      count += 1
    }
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
  let network = Network(input)
  return network.countGhostSteps()
}
