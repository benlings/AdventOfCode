import Foundation
import AdventCore

fileprivate struct State: Hashable {
  var position: Offset = .zero
  var direction: Offset
  var moves: Int = 1

  func next(angle: Int) -> State {
    var copy = self
    if angle == 0 {
      copy.moves += 1
    } else {
      copy.moves = 1
    }
    copy.direction.rotate(angle: angle)
    copy.position += copy.direction
    return copy
  }

  func neighbours() -> [State] {
    var neighbours = [next(angle: -90), next(angle: 90)]
    if moves < 3 {
      neighbours.append(next(angle: 0))
    }
    return neighbours
  }
}

fileprivate func findShortestPath(start: State, isEnd: (State) -> Bool, nextStates: (State) -> [(cost: Int, next: State)]) -> Int? {
  var costs = [start: 0]
  var toVisit = [start : 0] as PriorityQueue
  while let current = toVisit.popMin() {
    if isEnd(current) {
      return costs[current]
    }
    let currentCost = costs[current, default: .max]
    for (neighbourCost, neighbour) in nextStates(current) {
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
  return findShortestPath(start: State(direction: .east)) {
    $0.position == end } nextStates: { current in
      current.neighbours().compactMap {
        grid.contains($0.position) ? (grid[$0.position], $0) : nil
      }
    } ?? 0
}

public func day17_2(_ input: String) -> Int {
  0
}
