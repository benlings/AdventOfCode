import Foundation
import AdventCore
import DequeModule

struct Module: Identifiable, Hashable {
  enum Pulse: Hashable {
    case low, high
  }

  enum ModuleType: Hashable {
    case broadcast
    case flipFlop(state: Bool)
    case conjuction(lastInput: [Module.ID: Pulse])
  }

  var id: String
  var type: ModuleType
  var destinations: [Module.ID]

  mutating func register(input: Module.ID) {
    guard case .conjuction(lastInput: var inputs) = type else { return }
    inputs[input] = .low
    self.type = .conjuction(lastInput: inputs)
  }

  mutating func receive(_ pulse: Pulse, from input: Module.ID) -> [(to: Module.ID, pulse: Pulse)] {
    switch self.type {
    case .broadcast:
      return destinations.map { ($0, pulse) }
    case .flipFlop(state: let isOn):
      switch pulse {
      case .high: return []
      case .low:
        defer { type = .flipFlop(state: !isOn) }
        return destinations.map { ($0, isOn ? .low : .high) }
      }
    case .conjuction(lastInput: var inputs):
      inputs[input] = pulse
      let allHigh = inputs.values.allSatisfy { $0 == .high }
      defer { type = .conjuction(lastInput: inputs) }
      return destinations.map { ($0, allHigh ? .low : .high) }
    }
  }

}

extension Scanner {
  func scanModuleType() -> Module.ModuleType {
    if scanString("%") != nil {
      return .flipFlop(state: false)
    } else if scanString("&") != nil {
      return .conjuction(lastInput: [:])
    } else {
      return .broadcast
    }
  }
}

extension Module {
  init?(_ description: String) {
    let s = Scanner(string: description)
    guard case let type = s.scanModuleType(),
          let id = s.scanCharacters(from: .letters),
          let _ = s.scanString("->"),
          case let dests = s.scanSequence(separator: ",", scanElement: { s.scanCharacters(from: .letters) })
    else { return nil }
    self = Module(id: id, type: type, destinations: dests)
  }
}

struct ModuleSystem {
  var modules: [Module.ID: Module]
  var counts: [Module.Pulse: Int]

  init(_ description: String) {
    modules = description.lines().compactMap(Module.init).toDictionary()
    // Initialise conjuction inputs
    for m in modules.values {
      for d in m.destinations {
        modules[d]?.register(input: m.id)
      }
    }
    counts = [:]
  }

  mutating func sendPulse() {
    counts[.low, default: 0] += 1
    var pulses: Deque<(from: Module.ID, to: Module.ID, Module.Pulse)> = [("button", "broadcaster", .low)]
    while let (from, to, pulse) = pulses.popFirst() {
      if var m = modules[to] {
        let onward = m.receive(pulse, from: from)
        for (pulse, o) in onward.grouped(by: \.pulse) {
          counts[pulse, default: 0] += o.count
        }
        pulses.append(contentsOf: onward.map { (from: to, to: $0.to, pulse: $0.pulse) })
        modules[to] = m
      }
    }
  }
}


public func day20_1(_ input: String) -> Int {
  var system = ModuleSystem(input)
  for _ in 0..<1000 {
    system.sendPulse()
  }
  return system.counts.values.product()
}

public func day20_2(_ input: String) -> Int {
  0
}
