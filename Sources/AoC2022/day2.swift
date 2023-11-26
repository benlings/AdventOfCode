import Foundation
import AdventCore

public enum GameMove : Int {
    case rock = 1
    case paper = 2
    case scissors = 3
}

public enum GameResult : Int {
    case win = 6
    case lose = 0
    case draw = 3
}

extension Scanner {
    func scanMove() -> GameMove? {
        guard let m = scanCharacter() else { return nil }
        switch m {
        case "A", "X": return .rock
        case "B", "Y": return .paper
        case "C", "Z": return .scissors
        default: return nil
        }
    }

    func scanResult() -> GameResult? {
        guard let m = scanCharacter() else { return nil }
        switch m {
        case "X": return .lose
        case "Y": return .draw
        case "Z": return .win
        default: return nil
        }
    }
}

extension GameMove {

    var score: Int {
        rawValue
    }

    static func parse(moves: String) -> (GameMove, GameMove)? {
        let scanner = Scanner(string: moves)
        guard let m1 = scanner.scanMove(),
              let m2 = scanner.scanMove() else {
            return nil
        }
        return (m1, m2)
    }

    static func parse2(moves: String) -> (GameMove, GameResult)? {
        let scanner = Scanner(string: moves)
        guard let m = scanner.scanMove(),
              let r = scanner.scanResult() else {
            return nil
        }
        return (m, r)
    }

    static func result(move: (GameMove, GameMove)) -> GameResult {
        switch move {
        case (.rock, .rock): return .draw
        case (.rock, .paper): return .win
        case (.rock, .scissors): return .lose
        case (.paper, .rock): return .lose
        case (.paper, .paper): return .draw
        case (.paper, .scissors): return .win
        case (.scissors, .rock): return .win
        case (.scissors, .paper): return .lose
        case (.scissors, .scissors): return .draw
        }
    }

    static func result(move: (GameMove, GameResult)) -> GameMove {
        switch move {
        case (.rock, .draw): return .rock
        case (.rock, .win): return .paper
        case (.rock, .lose): return .scissors
        case (.paper, .lose): return .rock
        case (.paper, .draw): return .paper
        case (.paper, .win): return .scissors
        case (.scissors, .win): return .rock
        case (.scissors, .lose): return .paper
        case (.scissors, .draw): return .scissors
        }
    }

    static func score(move: (GameMove, GameMove)) -> Int {
        result(move: move).rawValue + move.1.score
    }

    static func score(move: (GameMove, GameResult)) -> Int {
        result(move: move).score + move.1.rawValue
    }

    static func parse1(guide: [String]) -> [(GameMove, GameMove)] {
        guide.compactMap(GameMove.parse(moves:))
    }

    static func parse2(guide: [String]) -> [(GameMove, GameResult)] {
        guide.compactMap(GameMove.parse2(moves:))
    }

    public static func totalScore1(guide: [String]) -> Int {
        parse1(guide: guide).map(score(move:)).sum()
    }

    public static func totalScore2(guide: [String]) -> Int {
        parse2(guide: guide).map(score(move:)).sum()
    }
}

public func day2_1(_ input: [String]) -> Int {
    GameMove.totalScore1(guide: input)
}

public func day2_2(_ input: [String]) -> Int {
    GameMove.totalScore2(guide: input)
}
