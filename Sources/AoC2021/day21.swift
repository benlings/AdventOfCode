import Foundation
import AdventCore

extension Int {
    func mod1(_ i: Int) -> Int {
        (self - 1) % i + 1
    }
}

protocol Dice {
    mutating func roll() -> [Int]
}

extension Dice {
    mutating func roll3() -> [Int] {
        roll()
            .flatMap { prev in roll().map { prev + $0 } }
            .flatMap { prev in roll().map { prev + $0 } }
    }
}

struct DeterministicDice : Dice {
    var value: Int = 1
    var count: Int = 0

    mutating func roll() -> [Int] {
        count += 1
        defer {
            value += 1
            value = value.mod1(100)
        }
        return [value]
    }
}

public struct DiceGame {

    struct Player {
        var position: Int
        var score: Int = 0

        mutating func turn(roll: Int) {
            position += roll
            position = position.mod1(10)
            score += position
        }

        func turn<D : Dice>(dice: inout D) -> [Player] {
            dice.roll3().map { roll in
                var copy = self
                copy.turn(roll: roll)
                return copy
            }
        }
    }

    var currentPlayer: Player
    var nextPlayer: Player
    var whichPlayer = false

    mutating func swapPlayers() {
        swap(&currentPlayer, &nextPlayer)
        whichPlayer.toggle()
    }

    func playTurn<D : Dice>(die: inout D) -> [DiceGame] {
        currentPlayer.turn(dice: &die).map { player in
            var newGame = self
            newGame.currentPlayer = player
            newGame.swapPlayers()
            return newGame
        }
    }

    mutating func play(die: inout DeterministicDice) {
        while nextPlayer.score < 1000 {
            self = playTurn(die: &die).first!
        }
    }

    var loser: Player {
        currentPlayer
    }

    public mutating func part1() -> Int {
        var die = DeterministicDice()
        play(die: &die)
        return loser.score * die.count
    }
}

extension DiceGame {
    public init(player1: Int, player2: Int) {
        self.currentPlayer = .init(position: player1)
        self.nextPlayer = .init(position: player2)
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
