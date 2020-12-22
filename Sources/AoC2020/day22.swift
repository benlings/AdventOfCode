import Foundation
import AdventCore

public struct CombatGame : Hashable {

    typealias Score = Int8

    var player1: [Score]
    var player2: [Score]

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

    @discardableResult
    public mutating func playRecursive() -> Int {
        var previousGames = Set<CombatGame>()
        while !finished {
            if previousGames.contains(self) {
                return 1
            }
            previousGames.insert(self)
            let c1 = player1.removeFirst()
            let c2 = player2.removeFirst()
            let winningPlayer: Int
            if player1.count >= c1 && player2.count >= c2 {
                var recursiveGame = CombatGame(player1: player1.prefix(Int(c1)).toArray(), player2: player2.prefix(Int(c2)).toArray())
                winningPlayer = recursiveGame.playRecursive()
            } else {
                winningPlayer = c1 > c2 ? 1 : 2
            }
            if winningPlayer == 1 {
                player1.append(contentsOf: [c1, c2])
            } else {
                player2.append(contentsOf: [c2, c1])
            }
        }
        return player1.count > player2.count ? 1 : 2
    }

    var winningDeck: [Score] {
        player1.count > 0 ? player1 : player2
    }

    public var winningScore: Int {
        return zip(winningDeck.reversed(), 1...).map { Int($0.0) * $0.1 }.sum()
    }

    public static func winningScore(input: String, recursive: Bool = false) -> Int {
        var game = Self(input)
        if recursive {
            game.playRecursive()
        } else {
            game.play()
        }
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
    CombatGame.winningScore(input: input, recursive: true)
}
