import Foundation
import AdventCore

enum Rock: Character, CustomStringConvertible {
  var description: String { String(rawValue) }

  case rounded = "O"
  case cube = "#"
  case space = "."
}

struct ReflectorDish {
  var grid: Grid<Rock>

  mutating func tilt() {
    for start in grid.range() {
      let rock = grid[start]
      if rock == .rounded {
        var pos = start
        repeat {
          pos += .south
        } while grid.contains(pos) && grid[pos] == .space
        pos -= .south
        if pos != start {
          grid[start] = .space
          grid[pos] = .rounded
        }
      }
    }
  }

  var northSupportLoad: Int {
    let rowCount = grid.size.north
    return grid.rowIndices.map { row in
      (rowCount - row) * grid.row(row).count { $0 == .rounded }
    }.sum()
  }
}

extension ReflectorDish {
  init(_ description: String) {
    self.grid = Grid(description, conversion: Rock.init)
  }
}

public func day14_1(_ input: String) -> Int {
  var dish = ReflectorDish(input)
  dish.tilt()
  return dish.northSupportLoad
}

public func day14_2(_ input: String) -> Int {
  0
}
