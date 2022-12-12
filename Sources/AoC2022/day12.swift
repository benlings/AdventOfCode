import Foundation
import AdventCore

public struct HeightMap {

    var map: Grid<Character>
    var start: Offset
    var end: Offset

    func height(_ offset: Offset) -> Int {
        let value = map[offset]
        if value == "E" {
            return 25
        }
        if value == "S" {
            return 0
        }
        return Int(value.asciiValue! - ("a" as Character).asciiValue!)
    }

    public func findShortestPath() -> Int {

        findLowestRiskPath(start: start, end: end, risk: { current, neighbour in
            if map.contains(neighbour) {
                let currentHeight = height(current)
                let neighbourHeight = height(neighbour)
                return neighbourHeight <= currentHeight + 1 ? 1 : nil
            }
            return nil
        })!
    }

    func findLowestRiskPath(start: Offset, end: Offset, risk: (Offset, Offset) -> Int?) -> Int? {
        var risks = [start: 0]
        var toVisit = [start: 0] as PriorityQueue
        while let current = toVisit.popMin() {
            if current == end {
                return risks[current]
            }
            let currentRisk = risks[current, default: .max]
            for neighbour in current.orthoNeighbours() {
                guard let neighbourRisk = risk(current, neighbour) else { continue }
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

extension HeightMap {

    public init(_ input: String) {
        map = Grid(input) { $0 }
        start = map.firstIndex(of: "S")!
        end = map.firstIndex(of: "E")!
    }

}


fileprivate let day12_input = Bundle.module.text(named: "day12")

public func day12_1() -> Int {
    HeightMap(day12_input).findShortestPath()
}

public func day12_2() -> Int {
    0
}
