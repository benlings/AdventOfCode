import Foundation
import AdventCore

public func day21_1(_ input: String, steps: Int = 64) -> Int {
  var map = Grid(input, conversion: { $0 })
  guard let start = map.firstIndex(of: "S") else { return 0 }
  var positions = Set([start])
  for _ in 0..<steps {
    var nextPositions = Set<Offset>()
    for p in positions {
      for n in p.orthoNeighbours() {
        if map.contains(n) && map[n] != "#" {
          nextPositions.insert(n)
        }
      }
    }
    positions = nextPositions
  }
  return positions.count
}

public func day21_2(_ input: String) -> Int {
  0
}
