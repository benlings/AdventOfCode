import Foundation
import AdventCore

enum Cucumber : Character {
    case east = ">"
    case south = "v"
    case none = "."
}

extension Cucumber: CustomStringConvertible {
    public var description: String {
        rawValue.description
    }
}


extension Cucumber {
    var direction: Offset? {
        switch self {
        case .east: return Offset(east: 1)
        case .south: return Offset(north: 1)
        case .none: return nil
        }
    }
}

public struct CucumberMap {
    var state: Grid<Cucumber>

    func wrapped(pos: Offset) -> Offset {
        pos.wrapped(size: state.size)
    }

    mutating func step(herd: Cucumber) {
        var newState = self.state
        for y in state.rowIndices {
            for x in state.columnIndices {
                let pos = Offset(east: x, north: y)
                let value = state[pos]
                if value == herd {
                    let next = wrapped(pos: pos + value.direction!)
                    if state[next] == .none {
                        newState[pos] = .none
                        newState[next] = value
                    }
                }
            }
        }
        self.state = newState
    }

    public mutating func stepUntilStable() -> Int {
        var count = 0
        var oldState: Grid<Cucumber>
        repeat {
            oldState = state
            step(herd: .east)
            step(herd: .south)
            count += 1
        } while state != oldState
        return count
    }

}

public extension CucumberMap {
    init(_ lines: [String]) {
        self.state = Grid(lines: lines)
    }
}

fileprivate let day25_input = Bundle.module.text(named: "day25").lines()

public func day25_1() -> Int {
    var map = CucumberMap(day25_input)
    return map.stepUntilStable()
}

public func day25_2() -> Int {
    0
}
