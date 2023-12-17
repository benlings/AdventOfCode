import Foundation
import AdventCore

enum Rock: Character, CustomStringConvertible {
  var description: String { String(rawValue) }

  case rounded = "O"
  case cube = "#"
  case space = "."
}

public func day14_1(_ input: String) -> Int {
  var grid = Grid(input, conversion: Rock.init)
  for n in grid.rowIndices {
    if n == 0 { continue }
    for e in grid.columnIndices {
      let start = Offset(east: e, north: n)
      let rock = grid[start]
      if rock == .rounded {
        var pos = start
        repeat {
          pos += .south
        } while grid.contains(pos) && grid[pos] == .space
        pos += .north
        if pos != start {
          grid[start] = .space
          grid[pos] = .rounded
        }
      }
    }
  }
  let rowCount = grid.size.north
  return grid.rowIndices.map { row in
    (rowCount - row) * grid.row(row).count { $0 == .rounded }
  }.sum()
}

public func day14_2(_ input: String) -> Int {
  0
}
