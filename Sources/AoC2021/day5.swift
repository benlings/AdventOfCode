import Foundation
import AdventCore

typealias Grid = [Offset : Int]

struct Line {
    var start: Offset
    var end: Offset

    var isHorizontal: Bool {
        start.north == end.north
    }

    var isVertical: Bool {
        start.east == end.east
    }

    var points: [Offset] {
        func range(_ start: Int, _ end: Int) -> StrideThrough<Int> {
            stride(from: start, through: end, by: end > start ? 1 : -1)
        }
        if isHorizontal {
            return range(start.east, end.east).map { Offset(east: $0, north: start.north) }
        } else if isVertical {
            return range(start.north, end.north).map { Offset(east: start.east, north: $0) }
        }
        assert(false)
    }
}

extension Line {
    init?(_ description: String) {
        let scanner = Scanner(string: description)
        guard let line = scanner.scanLine() else {
            return nil
        }
        self = line
    }
}

fileprivate extension Scanner {

    func scanOffset() -> Offset? {
        guard let east = scanInt(),
              let _ = scanString(","),
              let north = scanInt() else {
            return nil
        }
        return Offset(east: east, north: north)
    }


    func scanLine() -> Line? {
        guard let start = scanOffset(),
              let _ = scanString("->"),
              let end = scanOffset() else {
            return nil
        }
        return Line(start: start, end: end)
    }
}

public struct VentField {

    var locations = Grid()

    mutating func record(lines: [Line]) {
        for line in lines {
            for point in line.points {
                locations[point, default: 0] += 1
            }
        }
    }

    func overlappingCount() -> Int {
        locations.values.count { $0 > 1 }
    }

    public static func countOverlappingLines(_ input: [String]) -> Int {
        let lines = input.compactMap(Line.init).filter { $0.isVertical || $0.isHorizontal }
        var field = VentField()
        field.record(lines: lines)
        return field.overlappingCount()
    }
}

fileprivate let day5_input = Bundle.module.text(named: "day5").lines()

public func day5_1() -> Int {
    VentField.countOverlappingLines(day5_input)
}

public func day5_2() -> Int {
    0
}
