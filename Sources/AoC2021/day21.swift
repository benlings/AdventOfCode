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

struct DiracDice : Dice {
    func roll() -> [Int] {
        [1, 2, 3]
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

public struct DiceGame : Hashable {

    struct Player : Hashable {
        var position: Int
        var score: Int = 0

        mutating func turn(roll: Int) {
            position += roll
            position = position.mod1(10)
            score += position
        }

        func turn(dice: inout some Dice) -> [Player] {
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

    func playTurn(die: inout some Dice) -> [DiceGame] {
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

    func play(die: inout DiracDice) -> [DiceGame : Int] {
        var state = [self : 1]
        while state.keys.contains(where: { $0.nextPlayer.score < 21 }) {
            state = state.flatMap { game, count -> [(DiceGame, Int)] in
                if game.nextPlayer.score < 21 {
                    return game.playTurn(die: &die).map { ($0, count) }
                } else {
                    return [(game, count)]
                }
            }.toDictionarySummingValues()
        }
        return state
    }

    var loser: Player {
        currentPlayer
    }

    public mutating func part1() -> Int {
        var die = DeterministicDice()
        play(die: &die)
        return loser.score * die.count
    }

    public func part2() -> Int {
        var die = DiracDice()
        return play(die: &die)
            .map { game, count in (game.whichPlayer, count) }
            .toDictionarySummingValues().values.max()!
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
    let game = DiceGame(player1: 3, player2: 10)
    return game.part2()
}
