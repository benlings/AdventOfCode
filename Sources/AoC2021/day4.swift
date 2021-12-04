import Foundation
import AdventCore

public struct Board
{
    var unmarkedNumbers: Set<Int>
    public var numbers: [[Int]]
}

public struct BingoGame
{
    public var pickedNumbers: [Int]
    public var boards: [Board]
}

extension Board {
    init(_ description: String) {
        self.numbers = description.lines().map { $0.split(separator: " ").ints() }
        self.unmarkedNumbers = self.numbers.flatten().toSet()
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
    0
}

public func day4_2() -> Int {
    0
}
