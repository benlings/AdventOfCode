import Foundation
import AdventCore

public struct MemoryGame {

    var startingNumbers: [Int]

    public func numberAt(_ iteration: Int) -> Int {
        var lastSeen = [:] as [Int : Int]
        for (i, n) in startingNumbers.enumerated().dropLast() {
            lastSeen[n] = i
        }
        var lastNumber = startingNumbers.last!
        var turnOfLastNumber = startingNumbers.count - 1
        for turn in startingNumbers.count..<iteration {
            let difference = turnOfLastNumber - (lastSeen[lastNumber] ?? turnOfLastNumber)
            lastSeen[lastNumber] = turnOfLastNumber
            lastNumber = difference
            turnOfLastNumber = turn
        }
        return lastNumber
    }

}

public extension MemoryGame {
    init(_ input: String) {
        startingNumbers = input.components(separatedBy: ",").compactMap(Int.init)
    }
}

fileprivate let input = Bundle.module.text(named: "day15")

public func day15_1() -> Int {
    MemoryGame(input).numberAt(2020)
}

public func day15_2() -> Int {
    0
}
