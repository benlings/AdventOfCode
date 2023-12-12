import Foundation
import AdventCore

/*

 ???.### 1,1,3  -> 3U
 .??..??...?##. 1,1,3   2U 2U 1U + 2
 ?#?#?#?#?#?#?#? 1,3,1,6  1U
 ????.#...#... 4,1,1
 ????.######..#####. 1,6,5
 ?###???????? 3,2,1

 */

struct Springs {

  enum Condition: Character {
    case operational = "."
    case damaged = "#"
    case unknown = "?"
  }

  var arrangement: [Condition]
  var groups: [Int]

  func arrangementsCount() -> Int {
    var combinations = [arrangement]
    for (i, condition) in arrangement.indexed() {
      if condition == .unknown {
        combinations = combinations.flatMap { a in
          var damaged = a
          damaged[i] = .damaged
          var operational = a
          operational[i] = .operational
          return [damaged, operational]
        }
      }
    }
    let totalDamaged = groups.sum()
    let possible = combinations
      .lazy
      .filter { $0.count(of: .damaged) == totalDamaged }
      .map { String($0.lazy.map(\.rawValue)) }
    let pattern = groups.map { "[?#]{\($0)}" }.joined(separator: "\\.+")
    let regex = try! Regex(pattern)
    return possible.count { p in 
      p.contains(regex)
    }
  }
}

extension Springs {
  init(_ description: String) {
    let parts = description.split(separator: " ")
    self.arrangement = parts[0].compactMap(Condition.init(rawValue:))
    self.groups = parts[1].split(separator: ",").compactMap { Int(String($0)) }
  }
}

public func day12_1(_ input: String) -> Int {
  input.lines().map {
    Springs($0).arrangementsCount()
  }.sum()
}

public func day12_2(_ input: String) -> Int {
  0
}
