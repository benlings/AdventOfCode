import Foundation
import AdventCore

struct EngineSchematic {
  
  struct Number: Hashable {
    var start: Offset
    var digits: String = ""

    var neighbours: Set<Offset> {
      var n = Set<Offset>()
      for pos in Line(start: start, horizontalLength: digits.count).points {
        n.formUnion(pos.neighbours())
      }
      return n
    }

    var value: Int? {
      Int(digits)
    }
  }
  
  var numbers: Set<Number>
  var symbols: Set<Offset>
  var stars: Set<Offset>

  func isPartNumber(_ number: Number) -> Bool {
    !number.neighbours.isDisjoint(with: symbols)
  }

  var partNumbers: [Int] {
    numbers
      .filter { isPartNumber($0) }
      .compactMap { $0.value }
  }

  var gearRatios: [Int] {
    stars.compactMap { star in
      let neighbours = numbers.filter { $0.neighbours.contains(star) }
      return neighbours.count == 2 ? neighbours.compactMap(\.value).product() : nil
    }
  }
}

extension EngineSchematic {
  init(_ description: String) {
    let digitsGrid: Grid<Character> = Grid(description) { c in
      c.isNumber ? c : "."
    }
    
    self.numbers = Set<Number>()
    for row in digitsGrid.rowIndices {
      var number: Number? = nil
      for column in digitsGrid.columnIndices {
        let offset = Offset(east: column, north: row)
        let digit = digitsGrid[offset]
        if digit != "." {
          // Start of number
          if number == nil {
            number = Number(start: offset)
          }
          number?.digits.append(digit)
        }
        
        // End of number - add it to collection
        if digit == "." || column == digitsGrid.columnIndices.upperBound - 1,
           let theNumber = number {
          self.numbers.insert(theNumber)
          number = nil
        }
      }
    }
    
    let symbolsGrid: Grid<Bit> = Grid(description) { c in
      if c.isNumber || c == "." {
        .off
      } else {
        .on
      }
    }
    self.symbols = symbolsGrid.toSparse()

    self.stars = Grid(description) { Bit($0 == "*") }.toSparse()
  }
}

public func day3_1(_ input: String) -> Int {
  let schematic = EngineSchematic(input)
  let partNumbers = schematic.partNumbers
  return partNumbers.sum()
}

public func day3_2(_ input: String) -> Int {
  let schematic = EngineSchematic(input)
  let partNumbers = schematic.gearRatios
  return partNumbers.sum()
}
