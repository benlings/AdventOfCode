import Foundation
import AdventCore

struct MirrorPattern {

  var size: Offset
  var rocks: Set<Offset>

/*
 012345678
     ><
 #.##..##.
 ..#.##.#.
 ##......#
 ##......#
 ..#.##.#.
 ..##..##.
 #.#.##.#.
     ><
 012345678
 */

  func hasReflection(column: Int) -> Bool {
    let range = max(0, 2 * column - size.east)..<min(size.east, 2 * column)
    return rocks.lazy
      .filter { range.contains($0.east) }
      .allSatisfy { rocks.contains(Offset(east: 2 * column - $0.east - 1, north: $0.north)) }
  }

  func hasReflection(row: Int) -> Bool {
    let range = max(0, 2 * row - size.north)..<min(size.north, 2 * row)
    return rocks.lazy
      .filter { range.contains($0.north) }
      .allSatisfy { rocks.contains(Offset(east: $0.east, north: 2 * row - $0.north - 1)) }
  }

  func summary() -> Int {
    for column in 1..<size.east {
      if hasReflection(column: column) {
        return column
      }
    }
    for row in 1..<size.north {
      if hasReflection(row: row) {
        return 100 * row
      }
    }
    return 0
  }

}

extension MirrorPattern {
  init(_ description: String) {
    let grid = Grid(description, conversion: Bit.init(pixel:))
    self.size = grid.size
    self.rocks = grid.toSparse()
  }
}

public func day13_1(_ input: String) -> Int {
  input
    .groups()
    .map { MirrorPattern($0).summary() }
    .sum()
}

public func day13_2(_ input: String) -> Int {
  0
}
