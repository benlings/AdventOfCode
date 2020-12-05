import Foundation
import AdventCore

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

fileprivate let day5_input = Bundle.module.text(named: "day5").lines()

public func day5_1() -> UInt {
    day5_input
        .compactMap(Seat.init(bsp:))
        .map { $0.id }
        .max() ?? 0
}

extension Collection where Element: AdditiveArithmetic {
    func sum() -> Element {
        reduce(Element.zero, +)
    }
}

public func day5_2() -> UInt {
    let seats = day5_input
        .compactMap(Seat.init(bsp:))
    let firstRow = seats.map(\.row).min()!
    let lastRow = seats.map(\.row).max()!
    let middleSeats = seats.filter { $0.row > firstRow && $0.row < lastRow }
        .map(\.id)
        .sorted(by: <)
    let allSeats = middleSeats.first!...middleSeats.last!
    let missingSeat = allSeats.sum() - middleSeats.sum()
    return missingSeat
}
