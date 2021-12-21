import Foundation
import AdventCore

extension Int {
    func mod1(_ i: Int) -> Int {
        (self - 1) % i + 1
    }
}

struct DeterministicDice {
    var value: Int = 1
    var count: Int = 0

    mutating func roll() -> Int {
        count += 1
        defer {
            value += 1
            value = value.mod1(100)
        }
        return value
    }

    mutating func roll3() -> Int {
        roll() + roll() + roll()
    }
}

public struct DiceGame {

    public init(player1: Int, player2: Int) {
        self.player1 = .init(position: player1)
        self.player2 = .init(position: player2)
    }


    struct Player {
        var position: Int
        var score: Int = 0

        mutating func turn(dice: inout DeterministicDice) {
            position += dice.roll3()
            position = position.mod1(10)
            score += position
        }
    }

    var player1: Player
    var player2: Player
    var dice = DeterministicDice()

    public mutating func play() {
        while true {
            player1.turn(dice: &dice)
            if player1.score >= 1000 {
                break
            }
            player2.turn(dice: &dice)
            if player2.score >= 1000 {
                break
            }
        }
    }

    var loser: Player {
        if (player1.score < player2.score) {
            return player1
        } else {
            return player2
        }
    }

    public var part1Result: Int {
        loser.score * dice.count
    }
}

fileprivate let day21_input = Bundle.module.text(named: "day21").lines()

public func day21_1() -> Int {
    var game = DiceGame(player1: 3, player2: 10)
    game.play()
    return game.part1Result
}

public func day21_2() -> Int {
    0
}
