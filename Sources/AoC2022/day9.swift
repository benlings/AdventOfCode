import Foundation
import AdventCore

public struct Motion {
    var direction: Offset
    var count: Int
}

extension Motion {
    init?(_ input: String) {
        let scanner = Scanner(string: input)
        guard let dir = scanner.scanUpToCharacters(from: .whitespaces),
              let c = scanner.scanInt() else {
            return nil
        }
        switch dir {
        case "U": direction = Offset(east: 0, north: 1)
        case "D": direction = Offset(east: 0, north: -1)
        case "L": direction = Offset(east: -1, north: 0)
        case "R": direction = Offset(east: 1, north: 0)
        default: return nil
        }
        count = c
    }

    public static func countTailPositions(_ input: some Sequence<String>, knots: Int = 2) -> Int {
        var ropes = Array(repeating: Offset(), count: knots)
        var visited: Set<Offset> = [ropes.last!]
        for move in input.compactMap(Motion.init) {
            for _ in 1...move.count {
                for (headIndex, tailIndex) in ropes.indices.adjacentPairs() {
                    if headIndex == 0 {
                        ropes[headIndex] += move.direction
                    }
                    if !ropes[headIndex].touching(ropes[tailIndex]) {
                        var difference = ropes[headIndex] - ropes[tailIndex]
                        if difference.east != 0 {
                            difference.east /= abs(difference.east)
                        }
                        if difference.north != 0 {
                            difference.north /= abs(difference.north)
                        }
                        ropes[tailIndex] += difference
                    }
                }
                visited.update(with: ropes.last!)
            }
        }
        return visited.count
    }


}

fileprivate let day9_input = Bundle.module.text(named: "day9").lines()

public func day9_1() -> Int {
    Motion.countTailPositions(day9_input)
}

public func day9_2() -> Int {
    Motion.countTailPositions(day9_input, knots: 10)
}
