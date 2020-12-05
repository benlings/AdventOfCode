import Foundation
import AdventCore

public extension Collection {
    func every(nth: Int) -> [Element] {
        self.enumerated()
            .filter { idx, _ in idx % nth == 0 }
            .map { $1 }
    }
}

public func count(trees: [[Int]], right: Int, down: Int) -> Int {
    let rowLength = trees.first!.count
    let indices = (0...).lazy.map { ($0 * right) % rowLength }
    let count = zip(indices,
                    trees.every(nth: down))
        .map { $1[$0] }
        .reduce(0, +)
    return count
}

public extension Array where Element == String {
    func trees() -> [[Int]] {
        self.map { line in
            line.map { $0 == "#" ? 1 : 0 }
        }
    }
}

fileprivate let day3_input = Bundle.module.text(named: "day3").lines()

public func day3_1() -> Int {
    let trees = day3_input.trees()
    return count(trees: trees, right: 3, down: 1)
}

/*
 Right 1, down 1.
 Right 3, down 1.
 Right 5, down 1.
 Right 7, down 1.
 Right 1, down 2.
 */
public func day3_2() -> Int {
    let trees = day3_input.trees()
    return
        count(trees: trees, right: 1, down: 1) *
        count(trees: trees, right: 3, down: 1) *
        count(trees: trees, right: 5, down: 1) *
        count(trees: trees, right: 7, down: 1) *
        count(trees: trees, right: 1, down: 2)
}

