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
        self.currentPlayer = .init(position: player1)
        self.nextPlayer = .init(position: player2)
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

    var currentPlayer: Player
    var nextPlayer: Player

    mutating func playTurn(die: inout DeterministicDice, winningScore: Int) -> Bool {
        currentPlayer.turn(dice: &die)
        if currentPlayer.score >= winningScore {
            return true
        }
        swap(&currentPlayer, &nextPlayer)
        return false
    }

    mutating func play(die: inout DeterministicDice, winningScore: Int = 1000) {
        while !playTurn(die: &die, winningScore: winningScore) {
            // nothing
        }
    }

    var loser: Player {
        nextPlayer
    }

    public mutating func part1() -> Int {
        var die = DeterministicDice()
        play(die: &die)
        return loser.score * die.count
    }
}

fileprivate let day21_input = Bundle.module.text(named: "day21").lines()

public func day21_1() -> Int {
    var game = DiceGame(player1: 3, player2: 10)
    return game.part1()
}

public func day21_2() -> Int {
    0
}
