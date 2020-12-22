import Foundation
import AdventCore

public struct CombatGame : Hashable {
    var player1: [Int]
    var player2: [Int]

    var finished: Bool {
        player1.count == 0 || player2.count == 0
    }

    public mutating func play() {
        while !finished {
            let c1 = player1.removeFirst()
            let c2 = player2.removeFirst()
            if c1 > c2 {
                player1.append(c1)
                player1.append(c2)
            } else {
                player2.append(c2)
                player2.append(c1)
            }
        }
    }

    public var winningScore: Int {
        let winner = player1.count > player2.count ? player1 : player2
        return zip(winner.reversed(), 1...).map { $0.0 * $0.1 }.sum()
    }

    public static func winningScore(input: String) -> Int {
        var game = Self(input)
        game.play()
        return game.winningScore
    }
}

public extension CombatGame {
    init(_ description: String) {
        let groups = description.groups()
        player1 = groups[0].lines().dropFirst().ints()
        player2 = groups[1].lines().dropFirst().ints()
    }
}

fileprivate let input = Bundle.module.text(named: "day22")

public func day22_1() -> Int {
    CombatGame.winningScore(input: input)
}

public func day22_2() -> Int {
    0
}
