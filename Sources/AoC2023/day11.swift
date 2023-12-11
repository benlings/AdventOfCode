import Foundation
import AdventCore

public func galaxyDistances(_ input: String, expansionFactor: Int = 2) -> Int {
  let image = Grid(input, conversion: Bit.init(pixel:))
  let grid = image.toSparse()
  let expandedRows = Set(image.rowIndices).subtracting(Set(grid.map(\.north)))
  let expandedColumns = Set(image.columnIndices).subtracting(Set(grid.map(\.east)))
  let expandedGrid = grid.map { offset in
    offset + Offset(east: (expansionFactor - 1) * expandedColumns.count { (0..<offset.east).contains($0) },
                    north: (expansionFactor - 1) * expandedRows.count { (0..<offset.north).contains($0) })
  }
//  let expandedImage = Grid(sparse: Set(expandedGrid))
//  let expandedRows2 = Set(expandedImage.rowIndices).subtracting(Set(expandedGrid.map(\.north)))
//  let expandedColumns2 = Set(expandedImage.columnIndices).subtracting(Set(expandedGrid.map(\.east)))
//  
//  print(expandedImage)

  return expandedGrid
    .combinations(ofCount: 2)
    .map { $0[0].manhattanDistance(to: $0[1]) }
    .sum()
}

public func day11_1(_ input: String) -> Int {
  galaxyDistances(input)
}

public func day11_2(_ input: String) -> Int {
  galaxyDistances(input, expansionFactor: 1_000_000)
}
