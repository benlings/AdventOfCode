import Foundation
import AdventCore

struct TreeMap {
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


    func visibleTreeCount() -> Int {
        treeHeights.range().filter(isVisible(offset:)).count
    }

    func scenicScore(offset: Offset) -> Int {
        Offset.orthoNeighbours().map { countVisible(offset: offset, direction: $0) }.product()
    }

    func countVisible(offset: Offset, direction: Offset) -> Int {
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

    func maxScenicScore() -> Int {
        treeHeights.range().map(scenicScore(offset:)).max()!
    }
}

extension TreeMap {
    init(_ description: String) {
        self.treeHeights = Grid(description, conversion: \.wholeNumberValue)
    }
}

public func day8_1(_ input: String) -> Int {
    TreeMap(input).visibleTreeCount()
}

public func day8_2(_ input: String) -> Int {
    TreeMap(input).maxScenicScore()
}
