import Foundation
import AdventCore

extension Offset {
    static func orthoNeighbours() -> [Offset] {
        return [Self(east: -1), Self(north: -1), Self(east: 1), Self(north: 1)]
    }
}

public struct HeightMap {
    var heights: [[Int]]

    var rowIndices: Range<Int> {
        heights.indices
    }

    var columnIndices: Range<Int>  {
        heights.columnIndices
    }

    subscript(position: Offset) -> Int {
        get {
            if rowIndices.contains(position.east),
               columnIndices.contains(position.north) {
                return heights[position.east][position.north]
            } else {
                return 10
            }
        }
    }

    func isMinimum(position: Offset) -> Bool {
        let height = self[position]
        return Offset.orthoNeighbours().allSatisfy { height < self[$0 + position] }
    }

    func lowPoints() -> [Offset] {
        var positions = [Offset]()
        for x in rowIndices {
            for y in columnIndices {
                let pos = Offset(east: x, north: y)
                if isMinimum(position: pos) {
                    positions.append(pos)
                }
            }
        }
        return positions
    }

    func risk(position: Offset) -> Int {
        self[position] + 1
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
    0
}
