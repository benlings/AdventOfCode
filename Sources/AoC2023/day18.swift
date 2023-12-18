import Foundation
import AdventCore

enum DigDirection: Character {
  case right = "R"
  case left = "L"
  case up = "U"
  case down = "D"

  var dir: Offset {
    switch self {
    case .right: .east
    case .left: .west
    case .up: .south
    case .down: .north
    }
  }
}

public func day18_1(_ input: String) -> Int {
  let instructions = input.lines().compactMap { line -> Offset? in
    let s = Scanner(string: line)
    guard let c = s.scanCharacter(),
          let direction = DigDirection(rawValue: c),
          let dist = s.scanInt()
    else { return nil }
    return dist * direction.dir
  }
  var start = Offset.zero
  var edge = Set<Offset>()
  for i in instructions {
    let end = start + i
    let line = Line(start: start, end: end)
    edge.formUnion(line.points)
    start = end
  }
  let grid = Grid(sparse: edge)
  return grid.area { point, offset in
    if point == .off {
      return .nonEdge
    } else {
      let n = offset + .north
      return grid.contains(n) && grid[n] == .on ? .northEdge : .otherEdge
    }
  } + edge.count
}

public func day18_2(_ input: String) -> Int {
  0
}
