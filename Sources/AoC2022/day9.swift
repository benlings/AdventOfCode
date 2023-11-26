import Foundation
import AdventCore

struct Motion {
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
                ropes[0] += move.direction
                for (headIndex, tailIndex) in ropes.indices.adjacentPairs() {
                    if !ropes[headIndex].touching(ropes[tailIndex]) {
                        let difference = ropes[headIndex] - ropes[tailIndex]
                        ropes[tailIndex] += difference.unit()
                    }
                }
                visited.update(with: ropes.last!)
            }
        }
        return visited.count
    }


}

public func day9_1(_ input: [String]) -> Int {
    Motion.countTailPositions(input)
}

public func day9_2(_ input: [String]) -> Int {
    Motion.countTailPositions(input, knots: 10)
}
