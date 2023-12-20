import Foundation
import AdventCore
import SE0270_RangeSet

struct Workflow: Identifiable {

  enum Destination: Equatable {
    case id(String)
    case terminal(String)
  }

  struct Rule {
    typealias Condition = (field: Character, operation: Operation, number: Int)
    enum Operation: Character {
      case lt = "<"
      case gt = ">"
    }
    var condition: Condition?
    var destination: Destination

    var range: (any RangeExpression<Int>)? {
      guard let condition else { return nil }
      switch condition.operation {
      case .lt: return ..<condition.number
      case .gt: return (condition.number + 1)...
      }
    }

    func refine(_ partRange: PartRange) -> (matching: PartRange, remaining: PartRange?) {
      guard let condition else { return (partRange, nil) }
      let range = switch condition.operation {
      case .lt: 0..<condition.number
      case .gt: (condition.number + 1)..<4001
      }
      var matching = partRange
      matching.fields[condition.field, default: RangeSet()].formIntersection(RangeSet(range))
      var remaining = partRange
      remaining.fields[condition.field, default: RangeSet()].remove(contentsOf: range)
      return (matching, remaining)
    }

    func matches(_ part: Part) -> Bool {
      guard let condition else { return true }
      let value = part.fields[condition.field]!
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
  var fields: [Character: Int]

  var total: Int { fields.values.sum() }
}

struct PartRange {
  var fields: [Character: RangeSet<Int>]

  var count: Int { fields.values.map(\.count).product() }
}

extension Scanner {
  // e.g. px{a<2006:qkq,m>2090:A,rfg}
  func scanWorkflow() -> Workflow? {
    guard let id = scanUpToString("{"),
       let _ = scanString("{"),
       case let rules = scanSequence(separator: ",", scanElement: { scanRule() }),
       let _ = scanString("}")
    else { return nil }
    return Workflow(id: id, rules: rules)
  }

  func scanCondition() -> Workflow.Rule.Condition? {
    scanOptional {
      guard let field = scanCharacter(),
            let op = scanCharacter(),
            let operation = Workflow.Rule.Operation(rawValue: op),
            let number = scanInt(),
            let _ = scanString(":")
      else { return nil }
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

  func scanField() -> (Character, Int)? {
    guard let key = scanCharacter(),
          let _ = scanString("="),
          let value = scanInt()
    else { return nil }
    return (key, value)
  }

  // {x=787,m=2655,a=1222,s=2876}
  func scanPart() -> Part? {
    guard let _ = scanString("{"),
          case let fields = scanSequence(separator: ",", scanElement: scanField),
          let _ = scanString("}")
    else { return nil }
    return Part(fields: fields.toDictionary())
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
  let g = input.groups()
  let workflows = g[0].lines().compactMap(Workflow.init).toDictionary()
  let r = RangeSet(1..<4001)
  var accepted = [PartRange]()
  var toVisit = [("in", PartRange(fields: "xmas".map { ($0, r) }.toDictionary()))]
  while let (id, range) = toVisit.popLast() {
    let workflow = workflows[id]!
    var range = range
    for rule in workflow.rules {
      let (matching, remaining) = rule.refine(range)
      if let remaining {
        range = remaining
      }
      switch rule.destination {
      case .terminal(let t):
        if t == "A" {
          accepted.append(matching)
        }
      case .id(let id):
        toVisit.append((id, matching))
      }
    }
  }
  return accepted.map(\.count).sum()
}
