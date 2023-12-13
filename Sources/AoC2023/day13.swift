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

  func reflectionDiferences(_ dim: WritableKeyPath<Offset, Int>, _ value: Int) -> Int {
    let dimSize = size[keyPath: dim]
    let range = max(0, 2 * value - dimSize)..<min(dimSize, 2 * value)
    let filtered = rocks.filter { range.contains($0[keyPath: dim]) }
    let reflected = filtered
      .map {
        var reflected = $0
        reflected[keyPath: dim] = 2 * value - $0[keyPath: dim] - 1
        return reflected
      }
      .toSet()
    return filtered.symmetricDifference(reflected).count
  }

  func summary(smudge: Int) -> Int {
    for column in 1..<size.east {
      let c = reflectionDiferences(\.east, column)
      if c == smudge * 2 {
        return column
      }
    }
    for row in 1..<size.north {
      let c = reflectionDiferences(\.north, row)
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
