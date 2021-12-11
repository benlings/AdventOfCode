import Foundation
import AdventCore

public struct EnergyLevels {

    var levels: [[Int]]
    public var flashes: Int = 0
    public var stepCount: Int = 0

    var rowIndices: Range<Int> {
        levels.indices
    }

    var columnIndices: Range<Int>  {
        levels.columnIndices
    }

    subscript(position: Offset) -> Int {
        get {
            if rowIndices.contains(position.east),
               columnIndices.contains(position.north) {
                return levels[position.east][position.north]
            } else {
                return 0
            }
        }
        set {
            if rowIndices.contains(position.east),
               columnIndices.contains(position.north) {
                levels[position.east][position.north] = newValue
            }
        }
    }

    public mutating func increment(pos: Offset) {
        self[pos] += 1
        if self[pos] == 10 {
            for neighbour in pos.neighbours() {
                increment(pos: neighbour)
            }
        }
    }

    public mutating func step() {
        for x in rowIndices {
            for y in columnIndices {
                let pos = Offset(east: x, north: y)
                increment(pos: pos)
            }
        }
        for x in rowIndices {
            for y in columnIndices {
                let pos = Offset(east: x, north: y)
                if self[pos] > 9 {
                    flashes += 1
                    self[pos] = 0
                }
            }
        }
        stepCount += 1
    }

    var isSynchronised: Bool {
        for x in rowIndices {
            for y in columnIndices {
                if self[Offset(east: x, north: y)] != 0 {
                    return false
                }
            }
        }
        return true
    }

    public mutating func iterate(steps: Int) {
        for _ in 0..<steps {
            step()
        }
    }

    public mutating func iterateUntilSynchronsed() {
        while !isSynchronised {
            step()
        }
    }

}


public extension EnergyLevels {
    init(_ description: String) {
        self.levels = description.lines().map { $0.compactMap(\.wholeNumberValue) }
    }
}

extension EnergyLevels : CustomStringConvertible {
    public var description: String {
        levels.map { $0.map(\.description).joined() }.lines()
    }
}

fileprivate let day11_input = Bundle.module.text(named: "day11")

public func day11_1() -> Int {
    var levels = EnergyLevels(day11_input)
    levels.iterate(steps: 100)
    return levels.flashes
}

public func day11_2() -> Int {
    var levels = EnergyLevels(day11_input)
    levels.iterateUntilSynchronsed()
    return levels.stepCount
}
