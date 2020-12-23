import Foundation
import AdventCore
import Algorithms

public struct CupGame {

    // 'currentCup' is the first cup in the array
    var cups: [Int]

    public mutating func play(moves: Int) {
        for _ in 0..<moves {
            playMove()
        }
    }

    /**
     * The crab picks up the three cups that are immediately clockwise of the current cup. They are removed from the circle; cup spacing is adjusted as necessary to maintain the circle.
     * The crab selects a destination cup: the cup with a label equal to the current cup's label minus one. If this would select one of the cups that was just picked up, the crab will keep subtracting one until it finds a cup that wasn't just picked up. If at any point in this process the value goes below the lowest value on any cup's label, it wraps around to the highest value on any cup's label instead.
     * The crab places the cups it just picked up so that they are immediately clockwise of the destination cup. They keep the same order as when they were picked up.
     * The crab selects a new current cup: the cup which is immediately clockwise of the current cup.
     */
    mutating func playMove() {
        let currentCup = cups[0]
        let pickedUpRange = 1...3
        let pickedUp = cups[pickedUpRange]
        var destinationCup = decrement(cup: currentCup)
        while pickedUp.contains(destinationCup) {
            destinationCup = decrement(cup: destinationCup)
        }
        cups.removeSubrange(1...3)
        let destinationIndex = cups.firstIndex(of: destinationCup)!
        cups.insert(contentsOf: pickedUp, at: destinationIndex + 1)
        cups.rotate(toStartAt: 1)
    }

    func decrement(cup: Int) -> Int {
        var result = cup - 1
        if result < 1 {
            result += 9
        }
        return result
    }

    public var cupOrder: String {
        let i = cups.firstIndex(of: 1)!
        var copy = cups
        copy.rotate(toStartAt: i)
        copy.removeFirst()
        return copy.map(String.init).joined()
    }

    public static func playGame(input: String) -> String {
        var game = CupGame(input)
        game.play(moves: 100)
        return game.cupOrder
    }

}

public extension CupGame {
    init(_ description: String) {
        cups = description.map(String.init).ints()
    }
}

fileprivate let input = "327465189"

public func day23_1() -> String {
    CupGame.playGame(input: input)
}

public func day23_2() -> Int {
    0
}
