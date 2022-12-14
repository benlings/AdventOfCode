import Foundation
import AdventCore
import Algorithms

public struct CaveStructure {
    var rocks: Set<Offset>
    var sand: Set<Offset> = []
    let bottom: Int
    let hasFloor: Bool

    func isBocked(_ pos: Offset) -> Bool {
        rocks.contains(pos) || sand.contains(pos) || (hasFloor && pos.north >= bottom)
    }

    static let moves = [Offset(east: 0, north: 1), Offset(east: -1, north: 1), Offset(east: 1, north: 1)]

    mutating func addSandGrain(startLocation: Offset) -> Bool {
        var pos = startLocation
        if isBocked(pos) { return false }
        while pos.north < bottom {
            var atRest = true
            for move in Self.moves {
                let next = pos + move
                if !isBocked(next) {
                    // Move succeeded
                    pos = next
                    atRest = false
                    break
                }
            }
            if atRest {
                sand.insert(pos)
                return true
            }
        }
        return false
    }

    public func countSand() -> Int {
        var copy = self
        while copy.addSandGrain(startLocation: Offset(east: 500, north: 0)) {

        }
        return copy.sand.count
    }
}

public extension CaveStructure {
    init(_ input: some Sequence<String>, hasFloor: Bool = false) {
        rocks = []
        for line in input {
            let scanner = Scanner(string: line)
            let path = scanner.scanLineSequence()
            rocks.formUnion(path.flatMap(\.points))
        }
        self.hasFloor = hasFloor
        self.bottom = rocks.bottomRight.north + (hasFloor ? 2 : 0)
    }
}
extension Scanner {
    func scanLineSequence() -> [Line] {
        var points = [Offset]()
        while let o = scanOffset() {
            points.append(o)
            _ = scanString("->")
        }
        return points.adjacentPairs().map { Line(start: $0.0, end: $0.1) }
    }
}


fileprivate let day14_input = Bundle.module.text(named: "day14").lines()

public func day14_1() -> Int {
    CaveStructure(day14_input).countSand()
}

public func day14_2() -> Int {
    CaveStructure(day14_input, hasFloor: true).countSand()
}
