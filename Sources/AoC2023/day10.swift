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

  var connectingDirections: Set<Offset> {
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

}

struct PipeMaze {
  var grid: Grid<Pipe>

  func canMove(from previous: Offset, to point: Offset) -> Bool {
    guard grid.contains(point) else { return false }
    let directions = grid[point].connectingDirections
    let entryDirection = previous - point
    return directions.contains(entryDirection) && directions.count == 2
  }

  func connections(_ point: Offset) -> [Offset] {
    let connectedNeighbours = grid[point].connectingDirections.map { point + $0 }
    return connectedNeighbours.compactMap { neighbour in
      canMove(from: point, to: neighbour) ? neighbour : nil
    }
  }

  func furthestDistance() -> Int? {
    guard let start = grid.firstIndex(of: .start) else { return nil }
    var next = connections(start)
    assert(next.count == 2)
    var current = [start, start]
    var distance = 1
    while next[0] != next[1] && current[0] != next[1] {
      let previous = current
      current = next
      next = zip(previous, current).map { prev, curr in
        connections(curr).first { $0 != prev }!
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
