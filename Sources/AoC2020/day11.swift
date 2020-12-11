import Foundation
import AdventCore


public struct WaitingArea {

    public enum Seat : Character {
        case floor = "."
        case empty = "L"
        case occupied = "#"
    }

    var seats: [[Seat]]

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
