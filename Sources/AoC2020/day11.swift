import Foundation
import AdventCore


public struct WaitingArea : Equatable {

    public enum Seat : Character {
        case floor = "."
        case empty = "L"
        case occupied = "#"
    }

    var seats: [[Seat]]

    var rowIndices: Range<Int> {
        seats[0].indices
    }

    var columnIndices: Range<Int>  {
        seats.indices
    }

    subscript(x: Int, y: Int) -> Seat {
        get {
            if columnIndices.contains(y),
               rowIndices.contains(x) {
                return seats[y][x]
            } else {
                return .floor
            }
        }
        set {
            assert(seats[y][x] != .floor)
            seats[y][x] = newValue
        }
    }

    func seatedNeighbours(x: Int, y: Int) -> Int {
        (self[x - 1, y - 1] == .occupied ? 1 : 0) +
            (self[x - 1, y] == .occupied ? 1 : 0) +
            (self[x - 1, y + 1] == .occupied ? 1 : 0) +
            (self[x, y - 1] == .occupied ? 1 : 0) +
            (self[x, y + 1] == .occupied ? 1 : 0) +
            (self[x + 1, y - 1] == .occupied ? 1 : 0) +
            (self[x + 1, y] == .occupied ? 1 : 0) +
            (self[x + 1, y + 1] == .occupied ? 1 : 0)
    }

    mutating func step() {
        let oldLayout = self
        for y in columnIndices {
            for x in rowIndices {
                switch oldLayout[x, y] {
                case .empty where oldLayout.seatedNeighbours(x: x, y: y) == 0:
                    self[x, y] = .occupied
                case .occupied where oldLayout.seatedNeighbours(x: x, y: y) >= 4:
                    self[x, y] = .empty
                default:
                    break
                }
            }
        }
    }

    public mutating func findSteadyState() {
        var oldLayout: Self
        repeat {
            oldLayout = self
            self.step()
        } while oldLayout != self
    }

    public var occupied: Int {
        seats.map { row in
            row.count(of: .occupied)
        }.sum()
    }

}

public extension WaitingArea {
    init(_ description: String) {
        seats = description
            .lines()
            .map {
                $0.compactMap(Seat.init(rawValue:))
            }
    }
}

extension WaitingArea : CustomStringConvertible {
    public var description: String {
        seats.map { row in
            String(row.map(\.rawValue))
        }.joined(separator: "\n")
    }
}


public func day11_1() -> Int {
    0
}

public func day11_2() -> Int {
    0
}
