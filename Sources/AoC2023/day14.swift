import Foundation
import AdventCore
import OrderedCollections

enum Rock: Character, Hashable, CustomStringConvertible {
  var description: String { String(rawValue) }

  case rounded = "O"
  case cube = "#"
  case space = "."
}

struct ReflectorDish: Hashable {
  var grid: Grid<Rock>


  func range(_ direction: Offset) -> [Offset] {
    switch direction {
    case .south:
      grid.rowIndices.flatMap { n in grid.columnIndices.map { e in Offset(east: e, north: n) } }
    case .north:
      grid.rowIndices.reversed().flatMap { n in grid.columnIndices.map { e in Offset(east: e, north: n) } }
    case .east:
      grid.columnIndices.reversed().flatMap { e in grid.rowIndices.map { n in Offset(east: e, north: n) } }
    case .west:
      grid.columnIndices.flatMap { e in grid.rowIndices.map { n in Offset(east: e, north: n) } }
    default: fatalError()
    }
  }

  mutating func tilt(_ direction: Offset) {
    for start in range(direction) {
      let rock = grid[start]
      if rock == .rounded {
        var pos = start
        repeat {
          pos += direction
        } while grid.contains(pos) && grid[pos] == .space
        pos -= direction
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
  dish.tilt(.south)
  return dish.northSupportLoad
}

public func day14_2(_ input: String) -> Int {
  ReflectorDish(input).extrapolate(count: 1_000_000_000) { dish in
    dish.tilt(.south)
    dish.tilt(.west)
    dish.tilt(.north)
    dish.tilt(.east)
  }.northSupportLoad
}
