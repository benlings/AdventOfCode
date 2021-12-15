import Foundation
import AdventCore
import PriorityQueueModule

public struct ChitonMap {
    var riskLevels: Grid<Int>

    let expandedSize = 5

    public func findLowestRiskPath() -> Int? {
        findLowestRiskPath(start: .zero,
                           end: Offset(east: riskLevels.columnIndices.upperBound - 1,
                                       north: riskLevels.rowIndices.upperBound - 1),
                           risk: risk(position:))
    }

    public func findLowestRiskPathExpanded() -> Int? {
        findLowestRiskPath(start: .zero,
                           end: Offset(east: riskLevels.columnIndices.upperBound * expandedSize - 1,
                                       north: riskLevels.rowIndices.upperBound * expandedSize - 1),
                           risk: risk(expandedPosition:))
    }


    func risk(position: Offset) -> Int? {
        riskLevels.contains(position) ? riskLevels[position] : nil
    }

    func risk(expandedPosition: Offset) -> Int? {
        let width = riskLevels.columnIndices.upperBound
        let height = riskLevels.rowIndices.upperBound
        guard expandedPosition.east >= 0 && expandedPosition.east < width * expandedSize &&
            expandedPosition.north >= 0 && expandedPosition.north < height * expandedSize
        else {
            return nil
        }
        let east = expandedPosition.east % width
        let north = expandedPosition.north % height
        let increment = expandedPosition.east / width + expandedPosition.north / height
        return (riskLevels[Offset(east: east, north: north)] + increment - 1) % 9 + 1
    }

    func findLowestRiskPath(start: Offset, end: Offset, risk: (Offset) -> Int?) -> Int? {
        var risks = [start: 0]
        var toVisit = [start: 0] as PriorityQueue
        while !toVisit.isEmpty {
            let current = toVisit.removeMin()
            let currentRisk = risks[current, default: .max]
            for neighbour in current.orthoNeighbours() {
                guard let neighbourRisk = risk(neighbour) else { continue }
                let alt = currentRisk + neighbourRisk
                if alt < risks[neighbour, default: .max] {
                    risks[neighbour] = alt
                    toVisit.insert(neighbour, priority: alt)
                }
            }
        }
        return risks[end]
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
    ChitonMap(day15_input).findLowestRiskPathExpanded()!
}
