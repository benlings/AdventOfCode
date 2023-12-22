import Foundation
import AdventCore

struct Garden {
  var map: Grid<Character>

  init(_ description: String) {
    self.map = Grid(description, conversion: { $0 })
  }

  var start: Set<Offset> {
    guard let start = map.firstIndex(of: "S") else { return [] }
    return [start]
  }

  func canMove(to neighbour: Offset) -> Bool {
    map.contains(neighbour) && map[neighbour] != "#"
  }

  func findNext(positions: inout Set<Offset>) {
    var nextPositions = Set<Offset>()
    for p in positions {
      for n in p.orthoNeighbours() {
        if canMove(to: n) {
          nextPositions.insert(n)
        }
      }
    }
    positions = nextPositions
  }
}

public func day21_1(_ input: String, steps: Int) -> Int {
  let garden = Garden(input)
  var positions = garden.start
  for _ in 0..<steps {
    garden.findNext(positions: &positions)
  }
  return positions.count
}

public func day21_2(_ input: String, steps: Int) -> Int {
  let garden = Garden(input)
  // Separate extrapolation for each grid. initial grid reaches equilibrium some time before 50 steps
  // Extrapolate positions within each extra grid from their starting Set<Offset>
  return garden.start.extrapolate(count: steps) { positions in
    garden.findNext(positions: &positions)
  }.count
}
