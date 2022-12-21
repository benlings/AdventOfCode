import Foundation
import AdventCore
import DequeModule

public struct HeightMap {
    var heights: Grid<Int>

    subscript(position: Offset) -> Int {
        get {
            heights.element(position) ?? 10
        }
    }

    func isMinimum(position: Offset) -> Bool {
        let height = self[position]
        return position.orthoNeighbours().allSatisfy { height < self[$0] }
    }

    func lowPoints() -> [Offset] {
        heights.indices.compactMap { pos in
            isMinimum(position: pos) ? pos : nil
        }
    }

    func risk(position: Offset) -> Int {
        self[position] + 1
    }

    func findBasin(startingAt point: Offset) -> Set<Offset> {

        // start at point
        // for each neighbour that's higher
        // add to set of additional points
        // subtract already tested points
        // iterate through those too

        var points: Set<Offset> = [point]
        var toSearch: Deque<Offset> = [point]
        while let search = toSearch.popFirst() {
            var newPoints = Set<Offset>()
            let height = self[search]
            for neighbour in search.orthoNeighbours() {
                if !points.contains(neighbour) {
                    let neighbourHeight = self[neighbour]
                    if height < neighbourHeight && neighbourHeight < 9 {
                        newPoints.insert(neighbour)
                    }
                }
            }
            toSearch.append(contentsOf: newPoints)
            points.formUnion(newPoints)
        }
        return points
    }

    public static func findBasins(input: String) -> [Set<Offset>] {
        let heightMap = HeightMap(input)
        return heightMap.lowPoints().map { heightMap.findBasin(startingAt: $0) }
    }

    public static func largestBasinsProduct(input: String) -> Int {
        findBasins(input: input).map(\.count).sorted().suffix(3).product()
    }

    public static func sumRiskLevels(input: String) -> Int {
        let heightMap = HeightMap(input)
        return heightMap.lowPoints().map { heightMap.risk(position: $0) }.sum()
    }

}

extension HeightMap {
    init(_ description: String) {
        self.heights = description.lines().map { $0.compactMap(\.wholeNumberValue) }
    }
}

fileprivate let day9_input = Bundle.module.text(named: "day9")

public func day9_1() -> Int {
    HeightMap.sumRiskLevels(input: day9_input)
}

public func day9_2() -> Int {
    HeightMap.largestBasinsProduct(input: day9_input)
}
