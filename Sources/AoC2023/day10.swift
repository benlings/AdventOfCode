import Foundation
import AdventCore

enum Pipe: Character, CaseIterable {
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

  init?(connectingDirections: [Offset]) {
    let directions = Set(connectingDirections)
    let pipe = Self.allCases.filter { $0 != .start }.first { $0.connectingDirections == directions }
    guard let pipe else { return nil }
    self = pipe
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

  func traceRoute() -> Grid<Pipe>? {
    guard let start = grid.firstIndex(of: .start) else { return nil }
    var next = connections(start)
    assert(next.count == 2)
    var current = [start, start]
    guard let inferredStart = Pipe(connectingDirections: zip(next, current).map(-)) else { return nil }
    var route = Grid(repeating: Pipe.ground, size: grid.size)
    route[start] = inferredStart
    next.forEach { route[$0] = grid[$0] }
    while next[0] != next[1] && current[0] != next[1] {
      let previous = current
      current = next
      next = zip(previous, current).map { prev, curr in
        connections(curr).first { $0 != prev }!
      }
      next.forEach { route[$0] = grid[$0] }
    }

    return route
  }

  func countInside() -> Int? {
    guard let route = traceRoute() else { return nil }
    var count = 0
    for row in route.rows() {
      var inside = false
      for pipe in row {
        if pipe == .ground {
          if inside { count += 1 }
        } else if pipe.connectingDirections.contains(.north) {
          inside.toggle()
        }
      }
    }
    return count
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
  let grid = PipeMaze(input)
  return grid.countInside()!
}
