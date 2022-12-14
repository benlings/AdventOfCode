//
//  File.swift
//  
//
//  Created by Ben Lings on 14/12/2022.
//

import Foundation

public struct Line {

    public init(start: Offset, end: Offset) {
        self.start = start
        self.end = end
    }

    var start: Offset
    var end: Offset

    public enum Orientation {
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

    public var orientation: Orientation {
        let difference = direction
        switch (difference.east, difference.north) {
        case (_, 0): return .horizontal
        case (0, _): return .vertical
        case let (e, n) where abs(e) == abs(n): return .diagonal
        default: fatalError("Unsupported orientation")
        }
    }

    public var points: [Offset] {
        var point = start
        let offset = unitDirection
        let iterator: AnyIterator<Offset> = AnyIterator {
            defer { point += offset }
            return point == end ? nil : point
        }
        return Array(iterator) + [end]
    }
}

public extension Line {
    init?(_ description: String) {
        let scanner = Scanner(string: description)
        guard let line = scanner.scanLine() else {
            return nil
        }
        self = line
    }
}

public extension Scanner {

    func scanLine() -> Line? {
        guard let start = scanOffset(),
              let _ = scanString("->"),
              let end = scanOffset() else {
            return nil
        }
        return Line(start: start, end: end)
    }
}
