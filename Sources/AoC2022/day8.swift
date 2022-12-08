import Foundation
import AdventCore

public struct TreeMap {
    var treeHeights: Grid<Int>

    public func visibleTreeCount() -> Int {
        var count = 0
        let range = OffsetRange(southWest: .zero, northEast: treeHeights.size - Offset(east: 1, north: 1))
        let directions = Offset.orthoNeighbours()
        for offset in range {
            let height = treeHeights[offset]
            var isVisible = false
            for direction in directions {
                isVisible = true
                var tree = offset + direction
                while treeHeights.contains(tree) {
                    if treeHeights[tree] >= height {
                        isVisible = false
                        break
                    }
                    tree += direction
                }
                if isVisible {
                    break;
                }
            }
            if isVisible {
                count += 1
            }
        }
        return count
    }
}

public extension TreeMap {
    init(_ description: String) {
        self.treeHeights = Grid(description, conversion: \.wholeNumberValue)
    }
}

fileprivate let day8_input = Bundle.module.text(named: "day8")

public func day8_1() -> Int {
    TreeMap(day8_input).visibleTreeCount()
}

public func day8_2() -> Int {
    0
}
