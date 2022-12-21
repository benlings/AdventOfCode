import Foundation
import AdventCore

class CircularList<Element : Hashable> {

    func append(_ node: Element) {
        nextLookup[node] = nextLookup[current]
        nextLookup[current] = node
    }

    func append<S : BidirectionalCollection>(contentsOf elements: S) where S.Element == Element {
        for e in elements.reversed() {
            append(e)
        }
    }

    func removeAfter(count: Int) -> [Element] {
        var result = [Element]()
        var e = current
        for _ in 0..<count {
            let next = nextLookup[e]!
            result.append(next)
            e = next
        }
        nextLookup[current] = nextLookup[e]
        return result
    }

    func prefix(_ count: Int) -> [Element] {
        var result = [Element]()
        var e = self
        for _ in 0..<count {
            let nextNode: Node = e.next
            assert(nextNode !== self)
            result.append(nextNode.value)
            e = nextNode
        }
        return result
    }

    var nextLookup: [Element : Element] = [:]

    var current: Element

}

public struct CupGame {

    var cups: CircularList<Int>
    var count: Int

    public mutating func play(moves: Int) {
        for i in 0..<moves {
            if (i % 100000 == 0) {
                print("Iteration \(i)")
            }
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
        let currentCup = cups.current
        let pickedUp = cups.removeAfter(count: 3)
        var destinationCup = decrement(cup: currentCup)
        let values = pickedUp.map(\.value)
        while values.contains(destinationCup) {
            destinationCup = decrement(cup: destinationCup)
        }
        let destinationNode = cups.nodeLookup[destinationCup]!
        destinationNode.append(nodes: pickedUp)
        cups.current = cups.current.next
    }

    func decrement(cup: Int) -> Int {
        var result = cup - 1
        if result < 1 {
            result += count
        }
        return result
    }

    func cupsStartingFromOne(count: Int) -> [Int] {
        let starting = cups.nodeLookup[1]!
        return starting.prefix(count)
    }

    public var cupOrder: String {
        return cupsStartingFromOne(count: count - 1).map(String.init).joined()
    }

    public func starredCups() -> [Int] {
        Array(cupsStartingFromOne(count: 2))
    }

    public static func playGame1(input: String) -> String {
        var game = CupGame(input)
        game.play(moves: 100)
        return game.cupOrder
    }

    public static func playGame2(input: String) -> Int {
        var game = CupGame(input, extendedCount: 1000000)
        game.play(moves: 10000000)
        return game.starredCups().product()
    }

}

public extension CupGame {
    init(_ description: String, extendedCount: Int? = nil) {
        var cups: [Int] = description.map(String.init).ints()
        if let extendedCount = extendedCount {
            cups.append(contentsOf: (cups.count + 1)...extendedCount)
        }
        self.count = cups.count
        self.cups = CircularList(single: cups.removeFirst())
        self.cups.current.append(contentsOf: cups)
    }
}

fileprivate let input = "327465189"

public func day23_1() -> String {
    CupGame.playGame1(input: input)
}

public func day23_2() -> Int {
    CupGame.playGame2(input: input)
}
