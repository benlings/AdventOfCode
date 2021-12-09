import Foundation
import AdventCore

public struct HeightMap {
    var heights: [[Int]]

    var rowIndices: Range<Int> {
        heights.indices
    }

    var columnIndices: Range<Int>  {
        heights.columnIndices
    }

    subscript(x: Int, y: Int) -> Int {
        get {
            if rowIndices.contains(x),
               columnIndices.contains(y) {
                return heights[x][y]
            } else {
                return 10
            }
        }
    }

    func isMinimum(x: Int, y: Int) -> Bool {
        let height = self[x, y]
        return
            (self[x - 1, y] > height) &&
            (self[x, y - 1] > height) &&
            (self[x, y + 1] > height) &&
            (self[x + 1, y] > height)
    }

    func lowPointHeights() -> [Int] {
        var heights = [Int]()
        for x in rowIndices {
            for y in columnIndices {
                if isMinimum(x: x, y: y) {
                    heights.append(self[x, y])
                }
            }
        }
        return heights
    }

    public static func sumRiskLevels(input: String) -> Int {
        let heightMap = HeightMap(input)
        return heightMap.lowPointHeights().map { $0 + 1 }.sum()
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
