import Foundation

public struct Seat : Equatable {
    var row: UInt
    var column: UInt
    var id: UInt {
        row * 8 + column
    }
}

public extension Seat {
    init?(bsp: String) {
        guard bsp.count == 10 else {
            return nil
        }
        let binary = bsp
            .replacingOccurrences(of: "F", with: "0")
            .replacingOccurrences(of: "B", with: "1")
            .replacingOccurrences(of: "L", with: "0")
            .replacingOccurrences(of: "R", with: "1")
        guard let id = UInt(binary, radix: 2) else {
            return nil
        }
        row = id >> 3
        column = id & 0b111
    }
}

public func day5_1() -> UInt {
    readFile("day5.txt")
        .lines()
        .compactMap(Seat.init(bsp:))
        .map { $0.id }
        .max() ?? 0
}

public func day5_2() -> Int {
    0
}
