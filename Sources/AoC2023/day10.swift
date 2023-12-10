import Foundation
import AdventCore

enum Pipe: Character {
  case northSouth = "|"
  case eastWest = "-"
  // TODO sort out South being up :-/
  case southEast = "L"
  case southWest = "J"
  case northWest = "7"
  case northEast = "F"
  case ground = "."
  case start = "S"

  var connections: Set<Offset> {
    switch self {
    case .northSouth: [.north, .south]
    case .eastWest: [.east, .west]
    case .southWest: [.south, .west]
    case .southEast: [.south, .east]
    case .northEast: [.north, .east]
    case .northWest: [.north, .west]
    case .ground: []
    case .start: [.north, .south, .east, .west]
    }
  }

  func nextDirection(at point: Offset, startingFrom previous: Offset) -> Offset? {
    let entryDirection = previous - point
    guard connections.contains(entryDirection), connections.count == 2 else { return nil }
    return connections.subtracting([entryDirection]).first
  }
}

struct PipeMaze {
  var grid: Grid<Pipe>

  func connections(_ point: Offset) -> [(point: Offset, direction: Offset)] {
    grid[point].connections.map { point + $0 }.compactMap { neighbour in
      guard grid.contains(neighbour) else { return nil }
      return grid[neighbour].nextDirection(at: neighbour, startingFrom: point).map { (neighbour, $0) }
    }
  }

  func furthestDistance() -> Int? {
    guard let start = grid.firstIndex(of: .start) else { return nil }
    var next = connections(start)
    assert(next.count == 2)
    var current = next.map { (point: start, direction: $0.point - start) }
    var distance = 1
    while next[0].point != next[1].point && current[0].point != next[1].point {
      let previous = current
      current = next
      next = zip(previous, current).map { prev, curr in
        let connections = connections(curr.point)
        return connections.first { $0.point != prev.point }!
      }
      distance += 1
    }

    return distance
  }

}

extension PipeMaze {
  init(_ description: String) {
    grid = Grid(description)
  }
}

public func day10_1(_ input: String) -> Int {
  let grid = PipeMaze(input)
  return grid.furthestDistance()!
}

public func day10_2(_ input: String) -> Int {
  0
}
