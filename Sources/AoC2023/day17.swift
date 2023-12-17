import Foundation
import AdventCore

fileprivate struct State: Hashable {
  var position: Offset = .zero
  var direction: Offset
  var moves: Int = 0

  func next(angle: Int) -> State {
    var copy = self
    if angle == 0 {
      copy.moves += 1
    } else {
      copy.moves = 0
    }
    copy.direction.rotate(angle: angle)
    copy.position += copy.direction
    return copy
  }

  func neighbours() -> [State] {
    var neighbours = [next(angle: -90), next(angle: 90)]
    if moves < 2 {
      neighbours.append(next(angle: 0))
    }
    return neighbours
  }
}

fileprivate func findShortestPath(start: [State], end: Offset, cost: (State, State) -> Int?) -> Int? {
  var costs = [State: Int]()
  var toVisit = PriorityQueue<State, Int>()
  for s in start {
    costs[s] = 0
    toVisit.insert(s, priority: 0)
  }
  while let current = toVisit.popMin() {
    if current.position == end {
      return costs[current]
    }
    let currentCost = costs[current, default: .max]
    for neighbour in current.neighbours() {
      guard let neighbourCost = cost(current, neighbour) else { continue }
      let alt = currentCost + neighbourCost
      if alt < costs[neighbour, default: .max] {
        costs[neighbour] = alt
        toVisit.insert(neighbour, priority: alt)
      }
    }
  }
  return nil
}

public func day17_1(_ input: String) -> Int {
  let grid = Grid(input) { $0.wholeNumberValue }
  let end = grid.size - Offset(east: 1, north: 1)
  return findShortestPath(start: [State(direction: .east), State(direction: .north)],
                          end: end,
                          cost: { grid.contains($1.position) ? grid[$1.position] : nil })!
}

public func day17_2(_ input: String) -> Int {
  0
}
