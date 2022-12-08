import Foundation
import AdventCore

public struct TreeMap {
    var treeHeights: Grid<Int>

    func isVisible(offset: Offset) -> Bool {
        for direction in Offset.orthoNeighbours() {
            if isVisible(offset: offset, direction: direction) {
                return true
            }
        }
        return false
    }

    func isVisible(offset: Offset, direction: Offset) -> Bool {
        let height = treeHeights[offset]
        var tree = offset + direction
        while treeHeights.contains(tree) {
            if treeHeights[tree] >= height {
                return false
            }
            tree += direction
        }
        return true
    }


    public func visibleTreeCount() -> Int {
        treeHeights.range().filter(isVisible(offset:)).count
    }

    public func scenicScore(offset: Offset) -> Int {
        Offset.orthoNeighbours().map { countVisible(offset: offset, direction: $0) }.product()
    }

    public func countVisible(offset: Offset, direction: Offset) -> Int {
        var count = 0
        let height = treeHeights[offset]
        var tree = offset + direction
        while treeHeights.contains(tree) {
            if treeHeights[tree] >= height {
                return count + 1
            }
            count += 1
            tree += direction
        }
        return count
    }

    public func maxScenicScore() -> Int {
        treeHeights.range().map(scenicScore(offset:)).max()!
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
    TreeMap(day8_input).maxScenicScore()
}
