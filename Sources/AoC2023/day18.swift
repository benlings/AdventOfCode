import Foundation
import AdventCore

extension Offset {
  init?(digDirection: Character) {
    switch digDirection {
    case "R": self = .east
    case "L": self = .west
    case "U": self = .south
    case "D": self = .north
    default: return nil
    }
  }
}

public func day18_1(_ input: String) -> Int {
  let instructions = input.lines().compactMap { line -> Offset? in
    let s = Scanner(string: line)
    guard let c = s.scanCharacter(),
          let direction = Offset(digDirection: c),
          let dist = s.scanInt()
    else { return nil }
    return dist * direction
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
