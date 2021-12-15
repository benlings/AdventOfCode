import Foundation
import AdventCore

public struct ChitonMap {
    var riskLevels: Grid<Int>

    public func findLowestRiskPath() -> Int? {
        let start = Offset.zero;
        let end = Offset(east: riskLevels.columnIndices.last!, north: riskLevels.columnIndices.last!)
        var toVisit: Set<Offset> = [start]
        var risks = [Offset: Int]()
        var visited = Set<Offset>()
        var current = start;
        risks[start] = 0
        while !toVisit.isEmpty {
            current = toVisit.min { risks[$0, default: .max] }!
            toVisit.remove(current)
            if current == end {
                return risks[current]!
            }
            for neighbour in current.orthoNeighbours() {
                guard riskLevels.contains(neighbour),
                      !visited.contains(neighbour) else { continue }
                let alt = risks[current, default: .max] + riskLevels[neighbour]
                if alt < risks[neighbour, default: .max] {
                    risks[neighbour] = alt
                    toVisit.insert(neighbour)
                }
            }
            visited.insert(current)
        }
        return nil
    }
}

public extension ChitonMap {
    init(_ description: String) {
        self.riskLevels = Grid(description, conversion: \.wholeNumberValue)
    }
}

fileprivate let day15_input = Bundle.module.text(named: "day15")

public func day15_1() -> Int {
    ChitonMap(day15_input).findLowestRiskPath()!
}

public func day15_2() -> Int {
    0
}
