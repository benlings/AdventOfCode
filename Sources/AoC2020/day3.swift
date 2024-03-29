import Foundation
import AdventCore

public func count(trees: [[Int]], right: Int, down: Int) -> Int {
    let rowLength = trees.first!.count
    let count = zip((0...).striding(by: right),
                    trees.striding(by: down))
        .map { $1[$0 % rowLength] }
        .sum()
    return count
}

fileprivate extension Array<String> {
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

