import Foundation
import AdventCore

struct Line {
    var start: Offset
    var end: Offset

    enum Orientation {
        case horizontal
        case vertical
        case diagonal
    }

    var length: Int {
        switch orientation {
        case .horizontal:
            return abs(direction.east)
        case .vertical, .diagonal:
            return abs(direction.north)
        }
    }

    var direction: Offset {
        end - start
    }

    var unitDirection: Offset {
        (end - start) / length
    }

    var orientation: Orientation {
        let difference = direction
        switch (difference.east, difference.north) {
        case (_, 0): return .horizontal
        case (0, _): return .vertical
        case let (e, n) where abs(e) == abs(n): return .diagonal
        default: fatalError("Unsupported orientation")
        }
    }

    var points: [Offset] {
        var point = start
        let offset = unitDirection
        let iterator: AnyIterator<Offset> = AnyIterator {
            defer { point += offset }
            return point == end ? nil : point
        }
        return Array(iterator) + [end]
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

    var locations = [Offset : Int]()

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

    public static func countOverlappingLines(_ input: [String], includeDiagonal: Bool = false) -> Int {
        var orientations: Set<Line.Orientation> = [.horizontal, .vertical]
        if includeDiagonal {
            orientations.update(with: .diagonal)
        }
        let lines = input.compactMap(Line.init).filter { orientations.contains($0.orientation) }
        var field = VentField()
        field.record(lines: lines)
        return field.overlappingCount()
    }
}

fileprivate let day5_input = Bundle.module.text(named: "day5").lines()

public func day5_1() -> Int {
    VentField.countOverlappingLines(day5_input, includeDiagonal: false)
}

public func day5_2() -> Int {
    VentField.countOverlappingLines(day5_input, includeDiagonal: true)
}
