import Foundation
import AdventCore

public typealias PixelRow = UInt16

public struct CameraTile {
    public var id: Int
    public var pixels: [PixelRow]
    public var size: Int {
        pixels.count
    }

    public var topEdge: PixelRow {
        pixels.first!
    }
    public var bottomEdge: PixelRow {
        pixels.last!
    }
    public var leftEdge: PixelRow {
        column(size - 1)
    }
    public var rightEdge: PixelRow {
        column(0)
    }
    func column(_ index: Int) -> PixelRow {
        PixelRow(pixels
            .map { $0[bit: index] ? "1" : "0" }
            .joined(), radix: 2)!
    }
}

public extension CameraTile {
    init(_ description: String) {
        let lines = description.lines()
        let idScanner = Scanner(string: lines.first!)
        _ = idScanner.scanString("Tile")!
        id = idScanner.scanInt()!
        let pixelRows = lines.dropFirst()
        pixels = pixelRows.map { row in
            let binary = row
                .replacingOccurrences(of: "#", with: "1")
                .replacingOccurrences(of: ".", with: "0")
            return PixelRow(binary, radix: 2)!
        }
    }
}

public func day20_1() -> Int {
    0
}

public func day20_2() -> Int {
    0
}
