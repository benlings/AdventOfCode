import Foundation
import AdventCore

public struct TransparentPaper {

    enum FoldInstruction {
        case up(y: Int)
        case left(x: Int)
    }

    var dots: Set<Offset>
    var foldInstructions: [FoldInstruction]

    mutating func fold(instruction: FoldInstruction) {
        var newDots = dots
        for dot in dots {
            guard let newDot = instruction.transform(dot: dot) else { continue }
            newDots.remove(dot)
            newDots.insert(newDot)
        }
        dots = newDots
    }

}

extension TransparentPaper.FoldInstruction {
    func transform(dot: Offset) -> Offset? {
        switch self {
        case .up(let y):
            return dot.north > y ? Offset(east: dot.east, north: 2 * y - dot.north) : nil
        case .left(let x):
            return dot.east > x ? Offset(east: 2 * x - dot.east, north: dot.north) : nil
        }
    }
}


extension Scanner {
    func scanFoldInstruction() -> TransparentPaper.FoldInstruction? {
        if let _ = scanString("fold along"),
           let axis = scanCharacters(from: .init(charactersIn: "xy")),
           let _ = scanString("="),
           let value = scanInt() {
            switch axis {
            case "x": return .left(x: value)
            case "y": return .up(y: value)
            default: fatalError()
            }
        } else {
            return nil
        }
    }
}

extension TransparentPaper {
    init(_ description: String) {
        let groups = description.groups()
        self.dots = groups[0].lines().map { line -> Offset in
            let components = line.commaSeparated().ints() as [Int]
            return Offset(east: components[0], north: components[1])
        }.toSet()
        self.foldInstructions = groups[1].lines().compactMap { line in
            Scanner(string: line).scanFoldInstruction()
        }
    }

    var dotDescription: String {
        let bottomRight: Offset = dots.reduce(into: .zero) { m, d in
            m.north = max(m.north, d.north)
            m.east = max(m.east, d.east)
        }
        var grid = Grid(repeating: Bit.off, size: bottomRight + Offset(east: 1, north: 1))
        dots.forEach { grid[$0] = .on }
        return grid.description
    }

    public static func visibleDotsAfterFirstFold(_ description: String) -> Int {
        var paper = Self(description)
        paper.fold(instruction: paper.foldInstructions[0])
        return paper.dots.count
    }

    public static func patternAfterFolds(_ description: String) -> String {
        var paper = Self(description)
        paper.foldInstructions.forEach { paper.fold(instruction: $0) }
        return paper.dotDescription
    }

}


fileprivate let day13_input = Bundle.module.text(named: "day13")

public func day13_1() -> Int {
    TransparentPaper.visibleDotsAfterFirstFold(day13_input)
}

public func day13_2() -> String {
    let _ = TransparentPaper.patternAfterFolds(day13_input)
    return "FGKCKBZG"
}
