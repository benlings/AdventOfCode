import Foundation
import AdventCore

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
