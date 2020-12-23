import Foundation
import AdventCore
import Algorithms
import SE0270_RangeSet

public struct CupGame {

    // 'currentCup' is the first cup in the array
    var cups: [Int]
    var currentIndex: Int = 0

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
        let currentCup = cups[currentIndex]
        var pickedUpRangeSet = RangeSet<Int>()
        var pickedUp = [Int]()
        for i in (currentIndex + 1)...(currentIndex + 3) {
            pickedUpRangeSet.insert(i % cups.count, within: cups)
            pickedUp.append(cups[i % cups.count])
        }
        var destinationCup = decrement(cup: currentCup)
        while pickedUp.contains(destinationCup) {
            destinationCup = decrement(cup: destinationCup)
        }
        if pickedUpRangeSet.ranges.count == 1 {
            let destinationIndex = cups.firstIndex(of: destinationCup)!
            cups.moveSubranges(pickedUpRangeSet, to: destinationIndex + 1)
        } else {
            cups.removeSubranges(pickedUpRangeSet)
            let destinationIndex = cups.firstIndex(of: destinationCup)!
            cups.insert(contentsOf: pickedUp, at: destinationIndex + 1)
        }
        currentIndex = cups.firstIndex(of: currentCup)!
        currentIndex = (currentIndex + 1) % cups.count
    }

    func decrement(cup: Int) -> Int {
        var result = cup - 1
        if result < 1 {
            result += cups.count
        }
        return result
    }

    var cupsStartingFromOne: [Int] {
        let i = cups.firstIndex(of: 1)!
        var copy = cups
        copy.rotate(toStartAt: i)
        return copy
    }

    public var cupOrder: String {
        var copy = cupsStartingFromOne
        copy.removeFirst()
        return copy.map(String.init).joined()
    }

    public func starredCups() -> [Int] {
        Array(cupsStartingFromOne[1...2])
    }

    public static func playGame1(input: String) -> String {
        var game = CupGame(input)
        game.play(moves: 100)
        return game.cupOrder
    }

    public static func playGame2(input: String) -> Int {
        var game = CupGame(input)
        game.extendTo(totalCups: 1000000)
        game.play(moves: 10000000)
        return game.starredCups().product()
    }

    public mutating func extendTo(totalCups: Int) {
        cups.append(contentsOf: (cups.count + 1)...totalCups)
    }

}

public extension CupGame {
    init(_ description: String) {
        cups = description.map(String.init).ints()
    }
}

fileprivate let input = "327465189"

public func day23_1() -> String {
    CupGame.playGame1(input: input)
}

public func day23_2() -> Int {
    CupGame.playGame2(input: input)
}
