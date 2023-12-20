import Foundation
import AdventCore

struct Workflow: Identifiable {

  enum Destination: Equatable {
    case id(String)
    case terminal(String)
  }

  struct Rule {
    var predicate: (Part) -> Bool
    var destination: Destination
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

  func scanPredicate() -> ((Part) -> Bool)? {
    scanOptional {
      guard let id = scanCharacters(from: .letters),
            let op = scanCharacter(),
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
      let operation: (Int, Int) -> Bool
      switch op {
      case ">": operation = { $0 > $1 }
      case "<": operation = { $0 < $1 }
      default: return nil
      }
      return { operation($0[keyPath: field], number) }
    }
  }

  func scanRule() -> Workflow.Rule? {
    let pred = scanPredicate() ?? { _ in true }
    guard let dest = scanCharacters(from: .letters)
    else { return nil }
    return Workflow.Rule(
      predicate: pred,
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
        if rule.predicate(p) {
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
