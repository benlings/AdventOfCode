import Foundation
import AdventCore

enum CaveType {
    case start, end, small, big
}

public class Cave : Identifiable {
    public let id: String

    private var connected = Set<Cave>()

    init(id: String) {
        self.id = id
    }

    func connect(_ other: Cave) {
        connected.insert(other)
        other.connected.insert(self)
    }

    var type: CaveType {
        if id == "start" { return .start }
        else if id == "end" { return .end }
        else if id.contains(where: \.isLowercase) {
            return .small
        }
        else { return .big }
    }
}

extension Cave : Hashable {
    public static func == (lhs: Cave, rhs: Cave) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}

extension Cave: CustomStringConvertible {
    public var description: String {
        id
    }
}

extension Cave {

    func findPaths(visited: Set<Cave>) -> [[Cave]] {
        switch type {
        case .end: return [[self]]
        case .big: return connected.flatMap { $0.findPaths(visited: visited).map { [self] + $0 } }
        case .start, .small: return visited.contains(self) ? [] : connected.flatMap { $0.findPaths(visited: visited.union([self])).map { [self] + $0 } }
        }
    }

    func findPaths(visited: Set<Cave>, visitedSmallCave: Cave?) -> [[Cave]] {
        switch type {
        case .end: return [[self]]
        case .big: return connected.flatMap { $0.findPaths(visited: visited, visitedSmallCave: visitedSmallCave).map { [self] + $0 } }
        case .start:
            return visited.contains(self) ? [] : connected.flatMap { $0.findPaths(visited: visited.union([self]), visitedSmallCave: visitedSmallCave).map { [self] + $0 } }
        case .small:
            if visited.contains(self) {
                if visitedSmallCave == nil {
                    return connected.flatMap { $0.findPaths(visited: visited, visitedSmallCave: self).map { [self] + $0 } }
                } else {
                    return []
                }
            } else {
                return connected.flatMap { $0.findPaths(visited: visited.union([self]), visitedSmallCave: visitedSmallCave).map { [self] + $0 } }
            }
        }
    }

}

public struct CaveSystem {

    var caves: [String: Cave]

    public func findPaths() -> [[Cave]] {
        caves["start"]!.findPaths(visited: Set())
    }

    public func findRevistingPaths() -> [[Cave]] {
        caves["start"]!.findPaths(visited: Set(), visitedSmallCave: nil)
    }
}

extension CaveSystem {
    public init(_ description: [String]) {
        var caves = [String: Cave]()
        for rule in description {
            let scanner = Scanner(string: rule)
            guard let first = scanner.scanCharacters(from: .letters),
                  let _ = scanner.scanString("-"),
                  let second = scanner.scanCharacters(from: .letters)
            else { continue }
            let cave1 = caves[first, setDefault: Cave(id: first)]
            let cave2 = caves[second, setDefault: Cave(id: second)]
            cave1.connect(cave2)
        }
        self.caves = caves
    }

    public static func countPaths(_ description: String) -> Int {
        let caves = Self(description.lines())
        let paths = caves.findPaths()
        return paths.count
    }

    public static func countRevisitingPaths(_ description: String) -> Int {
        let caves = Self(description.lines())
        let paths = caves.findRevistingPaths()
        return paths.count
    }
}

fileprivate let day12_input = Bundle.module.text(named: "day12")

public func day12_1() -> Int {
    CaveSystem.countPaths(day12_input)
}

public func day12_2() -> Int {
    CaveSystem.countRevisitingPaths(day12_input)
}
