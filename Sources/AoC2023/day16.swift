import Foundation
import AdventCore

enum Mirror: Character {
  case splitterNS = "|"
  case splitterEW = "-"
  case mirrorSW = "/"
  case mirrorNW = #"\"#
  case space = "."

  func propagate(_ beam: Beam) -> Set<Beam> {
    switch self {
    case .splitterNS:
      if beam.direction == .north || beam.direction == .south {
        [beam.next(angle: 0)]
      } else {
        [beam.next(angle: -90), beam.next(angle: 90)]
      }
    case .splitterEW:
      if beam.direction == .east || beam.direction == .west {
        [beam.next(angle: 0)]
      } else {
        [beam.next(angle: -90), beam.next(angle: 90)]
      }
    case .mirrorSW:
      if beam.direction == .east || beam.direction == .west {
        [beam.next(angle: -90)]
      } else {
        [beam.next(angle: 90)]
      }
    case .mirrorNW:
      if beam.direction == .east || beam.direction == .west {
        [beam.next(angle: 90)]
      } else {
        [beam.next(angle: -90)]
      }
    case .space:
      [beam.next(angle: 0)]
    }
  }
}

struct Beam: Hashable {
  var position: Offset
  var direction: Offset

  func next(angle: Int) -> Beam {
    var direction = direction
    direction.rotate(angle: angle)
    return Beam(position: position + direction, direction: direction)
  }

}

struct MirrorGrid {
  var grid: Grid<Mirror>

  func propagate(entry: Beam) -> Int {
    var beams = Set([entry])
    var energized = Set([entry.position])
    var visited = beams
    while !beams.isEmpty {
      beams = beams
        .flatMap { beam in
          grid[beam.position].propagate(beam)
        }
        .filter { grid.contains($0.position) && !visited.contains($0) }
        .toSet()
      visited.formUnion(beams)
      energized.formUnion(beams.map(\.position))
    }
    return energized.count
  }
}

extension MirrorGrid {
  init(_ description: String) {
    self.grid = Grid(description, conversion: Mirror.init)
  }
}

public func day16_1(_ input: String) -> Int {
  var mirrors = MirrorGrid(input)
  return mirrors.propagate(entry: Beam(position: .zero, direction: .east))
}

public func day16_2(_ input: String) -> Int {
  let mirrors = MirrorGrid(input)
  var maxCount = 0
  for column in mirrors.grid.columnIndices {
    maxCount = max(maxCount, mirrors.propagate(entry: Beam(position: Offset(east: column, north: 0), direction: .north)))
    maxCount = max(maxCount, mirrors.propagate(entry: Beam(position: Offset(east: column, north: mirrors.grid.size.north - 1), direction: .south)))
  }
  for row in mirrors.grid.rowIndices {
    maxCount = max(maxCount, mirrors.propagate(entry: Beam(position: Offset(east: 0, north: row), direction: .east)))
    maxCount = max(maxCount, mirrors.propagate(entry: Beam(position: Offset(east: mirrors.grid.size.east - 1, north: row), direction: .west)))
  }
  return maxCount
}
