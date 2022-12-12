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
        findShortestPath(start: start)!
    }

    public func findAnyShortestPath() -> Int {
        let pathLengths = findPathLengths(start: end) { current, neighbour in
            if map.contains(neighbour) {
                let currentHeight = height(current)
                let neighbourHeight = height(neighbour)
                return neighbourHeight >= currentHeight - 1 ? 1 : nil
            }
            return nil
        }
        return map.range().filter { map[$0] == "a" }.compactMap { pathLengths[$0] }.min()!
    }

    func findShortestPath(start: Offset) -> Int? {
        findShortestPath(start: start, end: end, distance: { current, neighbour in
            if map.contains(neighbour) {
                let currentHeight = height(current)
                let neighbourHeight = height(neighbour)
                return neighbourHeight <= currentHeight + 1 ? 1 : nil
            }
            return nil
        })
    }

    func findShortestPath(start: Offset, end: Offset, distance: (Offset, Offset) -> Int?) -> Int? {
        var distances = [start: 0]
        var toVisit = [start: 0] as PriorityQueue
        while let current = toVisit.popMin() {
            if current == end {
                return distances[current]
            }
            let currentDistance = distances[current, default: .max]
            for neighbour in current.orthoNeighbours() {
                guard let neighbourDistance = distance(current, neighbour) else { continue }
                let alt = currentDistance + neighbourDistance
                if alt < distances[neighbour, default: .max] {
                    distances[neighbour] = alt
                    toVisit.insert(neighbour, priority: alt)
                }
            }
        }
        return distances[end]
    }

    func findPathLengths(start: Offset, distance: (Offset, Offset) -> Int?) -> [Offset : Int] {
        var distances = [start: 0]
        var toVisit = [start: 0] as PriorityQueue
        while let current = toVisit.popMin() {
            let currentDistance = distances[current, default: .max]
            for neighbour in current.orthoNeighbours() {
                guard let neighbourDistance = distance(current, neighbour) else { continue }
                let alt = currentDistance + neighbourDistance
                if alt < distances[neighbour, default: .max] {
                    distances[neighbour] = alt
                    toVisit.insert(neighbour, priority: alt)
                }
            }
        }
        return distances
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
    HeightMap(day12_input).findAnyShortestPath()
}
