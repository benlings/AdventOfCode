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

    func visibleSeatFromPosition(x:Int, y:Int, directionX: Int, directionY: Int) -> Seat {
        guard columnIndices.contains(y), rowIndices.contains(x) else {
            return .floor
        }
        switch self[x + directionX, y + directionY] {
        case .floor: return visibleSeatFromPosition(x: x + directionX, y: y + directionY,
                                                    directionX: directionX, directionY: directionY)
        case let seat: return seat
        }
    }

    func visibleNeighbours(x: Int, y: Int) -> Int {
        (visibleSeatFromPosition(x: x, y: y, directionX: -1, directionY: -1) == .occupied ? 1 : 0) +
            (visibleSeatFromPosition(x: x, y: y, directionX: -1, directionY: 0) == .occupied ? 1 : 0) +
            (visibleSeatFromPosition(x: x, y: y, directionX: -1, directionY: 1) == .occupied ? 1 : 0) +
            (visibleSeatFromPosition(x: x, y: y, directionX: 0, directionY: -1) == .occupied ? 1 : 0) +
            (visibleSeatFromPosition(x: x, y: y, directionX: 0, directionY: 1) == .occupied ? 1 : 0) +
            (visibleSeatFromPosition(x: x, y: y, directionX: 1, directionY: -1) == .occupied ? 1 : 0) +
            (visibleSeatFromPosition(x: x, y: y, directionX: 1, directionY: 0) == .occupied ? 1 : 0) +
            (visibleSeatFromPosition(x: x, y: y, directionX: 1, directionY: 1) == .occupied ? 1 : 0)

    }

    public mutating func step(strategy: Strategy = .neighbour) {
        let oldLayout = self
        for y in columnIndices {
            for x in rowIndices {
                if strategy == .neighbour {
                    switch oldLayout[x, y] {
                    case .empty where oldLayout.seatedNeighbours(x: x, y: y) == 0:
                        self[x, y] = .occupied
                    case .occupied where oldLayout.seatedNeighbours(x: x, y: y) >= 4:
                        self[x, y] = .empty
                    default:
                        break
                    }
                } else {
                    switch oldLayout[x, y] {
                    case .empty where oldLayout.visibleNeighbours(x: x, y: y) == 0:
                        self[x, y] = .occupied
                    case .occupied where oldLayout.visibleNeighbours(x: x, y: y) >= 5:
                        self[x, y] = .empty
                    default:
                        break
                    }

                }
            }
        }
    }

    public enum Strategy {
        case neighbour, visible
    }

    public mutating func findSteadyState(strategy: Strategy = .neighbour) {
        var oldLayout: Self
        repeat {
            oldLayout = self
            self.step(strategy: strategy)
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

fileprivate let input = Bundle.module.text(named: "day11")

fileprivate func calculateOccupied(_ strategy: WaitingArea.Strategy) -> Int {
    var waitingArea = WaitingArea(input)
    waitingArea.findSteadyState(strategy: strategy)
    return waitingArea.occupied
}

public func day11_1() -> Int {
    calculateOccupied(.neighbour)
}

public func day11_2() -> Int {
    calculateOccupied(.visible)
}
