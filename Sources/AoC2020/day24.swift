import Foundation
import AdventCore

public enum HexDirection : CaseIterable {
    case e, se, sw, w, nw, ne

    var offset: HexOffset {
        switch self {
        case .e: return HexOffset(east: 1)
        case .w: return HexOffset(east: -1)
        case .ne: return HexOffset(northEast: 1)
        case .sw: return HexOffset(northEast: -1)
        case .nw: return HexOffset(east: -1, northEast: 1)
        case .se: return HexOffset(east: 1, northEast: -1)
        }
    }
}

public struct HexOffset : Hashable {
    var east: Int = 0
    var northEast: Int = 0

    static func + (lhs: HexOffset, rhs: HexOffset) -> HexOffset {
        HexOffset(east: lhs.east + rhs.east, northEast: lhs.northEast + rhs.northEast)
    }

    static func from(directions: [HexDirection]) -> HexOffset {
        directions.reduce(HexOffset(), { $0 + $1.offset })
    }

    var neighbours: [HexOffset] {
        HexDirection.allCases.map {
            self + $0.offset
        }
    }
}

public struct TiledFloor {
    var instructions: [[HexDirection]]

    func followInstructions() -> Set<HexOffset> {
        var blackTiles = Set<HexOffset>()
        for i in instructions {
            let offset = HexOffset.from(directions: i)
            if blackTiles.contains(offset) {
                blackTiles.remove(offset)
            } else {
                blackTiles.insert(offset)
            }
        }
        return blackTiles
    }

    public func countBlack() -> Int {
        followInstructions().count
    }

    public func run(days: Int) -> Int {
        var blackTiles = followInstructions()
        for _ in 0..<days {
            var neighbours = [HexOffset : Int]()
            for offset in blackTiles {
                for n in offset.neighbours {
                    neighbours[n, default: 0] += 1
                }
            }
            var newTiles = Set<HexOffset>()
            for (offset, n) in neighbours {
                if blackTiles.contains(offset) ? (n == 1 || n == 2) : n == 2 {
                    newTiles.insert(offset)
                }
            }
            blackTiles = newTiles
        }
        return blackTiles.count
    }
}

fileprivate extension CharacterSet {
    static let northSouth = CharacterSet(charactersIn: "ns")
    static let eastWest = CharacterSet(charactersIn: "ew")
}

fileprivate extension Scanner {
    func scanHexDirection() -> HexDirection? {
        if let c1 = scanCharacter() {
            if c1 == "n" || c1 == "s",
               let c2 = scanCharacter() {
                switch (c1, c2) {
                case ("n", "e"): return .ne
                case ("n", "w"): return .nw
                case ("s", "e"): return .se
                case ("s", "w"): return .sw
                default:
                    return nil
                }
            } else {
                switch c1 {
                case "e": return .e
                case "w": return .w
                default:
                    return nil
                }
            }
        } else {
            return nil
        }
    }
}

public extension TiledFloor {
    init(_ description: String) {
        instructions = description.lines().map { line in
            let scanner = Scanner(string: line)
            var directions = [HexDirection]()
            while let d = scanner.scanHexDirection() {
                directions.append(d)
            }
            return directions
        }
    }
}

fileprivate let input = Bundle.module.text(named: "day24")

public func day24_1() -> Int {
    TiledFloor(input).countBlack()
}

public func day24_2() -> Int {
    TiledFloor(input).run(days: 100)
}
