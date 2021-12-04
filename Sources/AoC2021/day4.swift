import Foundation
import AdventCore

public struct Board
{
    var unmarkedNumbers: Set<Int> {
        lines.unionAll()
    }

    var lines: [Set<Int>]

    mutating func mark(number: Int) {
        for i in lines.indices {
            lines[i].remove(number)
        }
    }

    var isWin: Bool {
        lines.contains { $0.isEmpty }
    }
}

public struct BingoGame
{
    public var pickedNumbers: [Int]
    public var boards: [Board]

    public mutating func findWiningGame() -> Int? {
        for n in pickedNumbers {
            for b in boards.indices {
                boards[b].mark(number: n)
                if boards[b].isWin {
                    return boards[b].unmarkedNumbers.sum() * n
                }
            }
        }
        return nil
    }

    public mutating func findLosingGame() -> Int? {
        var gameIndices = Set(boards.indices)
        for n in pickedNumbers {
            for b in boards.indices {
                boards[b].mark(number: n)
                if boards[b].isWin {
                    gameIndices.remove(b)
                    if gameIndices.count == 0 {
                        return boards[b].unmarkedNumbers.sum() * n
                    }
                }
            }
        }
        return nil
    }


}

extension Board {
    init(_ description: String) {
        let numbers: [[Int]] = description.lines().map { $0.split(separator: " ").ints() }
        self.lines = numbers.map(Set.init) + numbers.columns().map(Set.init)
    }
}

public extension BingoGame {
    init(_ description: String) {
        let groups = description.groups()
        self.pickedNumbers = groups.first!.split(separator: ",").ints()
        self.boards = groups.dropFirst().map(Board.init)
    }
}

fileprivate let day4_input = Bundle.module.text(named: "day4")

public func day4_1() -> Int {
    var game = BingoGame(day4_input)
    return game.findWiningGame()!
}

public func day4_2() -> Int {
    var game = BingoGame(day4_input)
    return game.findLosingGame()!
}
