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

  var beams: Set<Beam> = [Beam(position: .zero, direction: .east)]
  var energized: Set<Offset> = [.zero]

  mutating func propagate() {
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
  }
}

extension MirrorGrid {
  init(_ description: String) {
    self.grid = Grid(description, conversion: Mirror.init)
  }
}

public func day16_1(_ input: String) -> Int {
  var mirrors = MirrorGrid(input)
  mirrors.propagate()
  return mirrors.energized.count
}

public func day16_2(_ input: String) -> Int {
  0
}
