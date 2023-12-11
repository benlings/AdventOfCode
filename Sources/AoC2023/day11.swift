import Foundation
import AdventCore

public func day11_1(_ input: String) -> Int {
  let image = Grid(input, conversion: Bit.init(pixel:))
  let grid = image.toSparse()
  let expandedRows = Set(image.rowIndices).subtracting(Set(grid.map(\.north)))
  let expandedColumns = Set(image.columnIndices).subtracting(Set(grid.map(\.east)))
  let expandedGrid = grid.map { offset in
    offset + Offset(east: expandedColumns.count { (0..<offset.east).contains($0) },
                    north: expandedRows.count { (0..<offset.north).contains($0) })
  }
  return expandedGrid
    .combinations(ofCount: 2)
    .map { $0[0].manhattanDistance(to: $0[1]) }
    .sum()
}

public func day11_2(_ input: String) -> Int {
  0
}
