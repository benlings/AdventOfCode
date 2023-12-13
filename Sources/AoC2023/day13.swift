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

  func reflectionCandidates(column: Int) -> (Set<Offset>, Set<Offset>) {
    let range = max(0, 2 * column - size.east)..<min(size.east, 2 * column)
    let filtered = rocks.filter { range.contains($0.east) }
    return (filtered, filtered
      .map { Offset(east: 2 * column - $0.east - 1, north: $0.north) }
      .toSet())
  }

  func reflectionCandidates(row: Int) -> (Set<Offset>, Set<Offset>) {
    let range = max(0, 2 * row - size.north)..<min(size.north, 2 * row)
    let filtered = rocks.filter { range.contains($0.north) }
    return (filtered, filtered
      .map { Offset(east: $0.east, north: 2 * row - $0.north - 1) }
      .toSet())
  }

  func summary(smudge: Int) -> Int {
    for column in 1..<size.east {
      let candidates = reflectionCandidates(column: column)
      let c = candidates.0.symmetricDifference(candidates.1).count
      if c == smudge * 2 {
        return column
      }
    }
    for row in 1..<size.north {
      let candidates = reflectionCandidates(row: row)
      let c = candidates.0.symmetricDifference(candidates.1).count
      if c == smudge * 2 {
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
    .map { MirrorPattern($0).summary(smudge: 0) }
    .sum()
}

public func day13_2(_ input: String) -> Int {
  input
    .groups()
    .map { MirrorPattern($0).summary(smudge: 1) }
    .sum()
}
