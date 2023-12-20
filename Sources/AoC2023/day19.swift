import Foundation
import AdventCore

struct Workflow: Identifiable {

  enum Destination: Equatable {
    case id(String)
    case terminal(String)
  }

  struct Rule {
    typealias Condition = (field: KeyPath<Part, Int>, operation: Operation, number: Int)
    enum Operation: Character {
      case lt = "<"
      case gt = ">"
    }
    var condition: Condition?
    var destination: Destination

    func matches(_ part: Part) -> Bool {
      guard let condition else { return true }
      let value = part[keyPath: condition.field]
      switch condition.operation {
      case .lt: return value < condition.number
      case .gt: return value > condition.number
      }
    }
  }

  var id: String
  var rules: [Rule]
}

struct Part {
  var x, m, a, s: Int

  var total: Int { x + m + a + s }
}

extension Scanner {
  // e.g. px{a<2006:qkq,m>2090:A,rfg}
  func scanWorkflow() -> Workflow? {
    guard let id = scanUpToString("{"),
       let _ = scanString("{"),
       case let rules = scanSequence(separator: ",", scanElement: { $0.scanRule() }),
       let _ = scanString("}")
    else { return nil }
    return Workflow(id: id, rules: rules)
  }

  func scanCondition() -> Workflow.Rule.Condition? {
    scanOptional {
      guard let id = scanCharacters(from: .letters),
            let op = scanCharacter(),
            let operation = Workflow.Rule.Operation(rawValue: op),
            let number = scanInt(),
            let _ = scanString(":")
      else { return nil }
      let field: KeyPath<Part, Int>
      switch id {
      case "x": field = \.x
      case "m": field = \.m
      case "a": field = \.a
      case "s": field = \.s
      default: return nil
      }
      return (field, operation, number)
    }
  }

  func scanRule() -> Workflow.Rule? {
    let cond = scanCondition()
    guard let dest = scanCharacters(from: .letters)
    else { return nil }
    return Workflow.Rule(
      condition: cond,
      destination: dest.allSatisfy(\.isUppercase) ? .terminal(dest) : .id(dest)
    )
  }

  // {x=787,m=2655,a=1222,s=2876}
  func scanPart() -> Part? {
    guard let _ = scanString("{x="),
          let x = scanInt(),
          let _ = scanString(",m="),
          let m = scanInt(),
          let _ = scanString(",a="),
          let a = scanInt(),
          let _ = scanString(",s="),
          let s = scanInt(),
          let _ = scanString("}")
    else { return nil }
    return Part(x: x, m: m, a: a, s: s)
  }
}

extension Workflow {
  init?(_ description: String) {
    let s = Scanner(string: description)
    guard let w = s.scanWorkflow() else { return nil }
    self = w
  }
}

extension Part {
  init?(_ description: String) {
    let s = Scanner(string: description)
    guard let p = s.scanPart() else { return nil }
    self = p
  }
}

public func day19_1(_ input: String) -> Int {
  let g = input.groups()
  let workflows = g[0].lines().compactMap(Workflow.init).toDictionary()
  let parts = g[1].lines().compactMap(Part.init)
  return parts.filter { p in
    var dest = Workflow.Destination.id("in")
    while case let .id(id) = dest {
      let workflow = workflows[id]!
      for rule in workflow.rules {
        if rule.matches(p) {
          dest = rule.destination
          break
        }
      }
    }
    return dest == .terminal("A")
  }.map(\.total).sum()
}

public func day19_2(_ input: String) -> Int {
  0
}
