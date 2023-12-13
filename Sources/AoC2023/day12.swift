import Foundation
import AdventCore
import Algorithms

/*

 ???.### 1,1,3  -> 3U
 .??..??...?##. 1,1,3   2U 2U 1U + 2
 ?#?#?#?#?#?#?#? 1,3,1,6  1U
 ????.#...#... 4,1,1
 ????.######..#####. 1,6,5
 ?###???????? 3,2,1

 */

fileprivate var cache: [Springs: Int] = [:]

struct Springs: Hashable {

  enum Condition: Character {
    case operational = "."
    case damaged = "#"
    case unknown = "?"
  }

  var arrangement: [Condition]
  var groups: [Int]

  func arrangementsCount() -> Int {

    func count(_ arrangement: some RandomAccessCollection<Condition>, _ groups: some RandomAccessCollection<Int>) -> Int {
      let key = Springs(arrangement: Array(arrangement), groups: Array(groups))
      if let c = cache[key] {
        return c
      }
      let c = count0(arrangement, groups)
      cache[key] = c
      return c
    }

    func count0(_ arrangement: some RandomAccessCollection<Condition>, _ groups: some RandomAccessCollection<Int>) -> Int {
//      print(String(arrangement.map(\.rawValue)), groups)
      let rest = arrangement.dropFirst()
      guard let firstCondition = arrangement.first,
            let firstGroup = groups.first
      else { return arrangement.allSatisfy { $0 != .damaged } && groups.isEmpty ? 1 : 0 }
      if arrangement.count < groups.sum() + groups.count - 1 {
        return 0
      }
      switch firstCondition {
      case .operational: return count(rest, groups)
      case .unknown:
        return count(rest, groups)
        + count(chain(CollectionOfOne(Condition.damaged), rest), groups)
      case .damaged:
        let prefix = arrangement.prefix(firstGroup)
        let remaining = arrangement.dropFirst(firstGroup)
        guard prefix.count == firstGroup,
              !prefix.contains(.operational),
              remaining.count == 0 || remaining.first != .damaged
        else { return 0 }

        let c = remaining.isEmpty ?
        count(remaining, groups.dropFirst()) :
        count(remaining.dropFirst(), groups.dropFirst())
//        print("found \(c): \(String(prefix.map(\.rawValue))) + \(String(remaining.map(\.rawValue)))")
        return c
      }
    }
    let c = count(arrangement, groups)
//    print(c)
    return c
  }
}

extension Springs {
  init(_ description: String, folded times: Int = 1) {
    let parts = description.split(separator: " ")
    self.arrangement = Array(repeating: parts[0].compactMap(Condition.init(rawValue:)), count: times).joined(by: { _, _ in .unknown})
    self.groups = Array(parts[1].split(separator: ",").compactMap { Int(String($0)) }.cycled(times: times))
  }
}

public func day12_1(_ input: String) -> Int {
  input.lines().map {
    Springs($0).arrangementsCount()
  }.sum()
}

public func day12_2(_ input: String) -> Int {
  input.lines().map {
    Springs($0, folded: 5).arrangementsCount()
  }.sum()
}
