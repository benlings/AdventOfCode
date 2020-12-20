import Foundation
import AdventCore

public typealias EdgeId = UInt16

extension EdgeId {

    init<S>(bits: S) where S : Sequence, S.Element == Bool {
        self = Self.init(bits.map { $0 ? "1" : "0" }.joined(), radix: 2)!
    }

    public func reversed(size: Int) -> EdgeId {
        var r = 0 as EdgeId
        for bit in 0..<size {
            r[bit: size - bit - 1] = self[bit: bit]
        }
        return r
    }
}

public enum TileEdge : CaseIterable {
    case top, right, bottom, left
}

public struct CameraTile {
    public var id: Int
    var pixels: [[Bool]]
    public var size: Int {
        pixels.count
    }

    public subscript(edge: TileEdge) -> EdgeId {
        get {
            switch edge {
            case .top: return row(0)
            case .right: return column(size - 1)
            case .bottom: return row(size - 1)
            case .left: return column(0)
            }
        }
    }

    func row(_ index: Int) -> EdgeId {
        EdgeId(bits: pixels[index])
    }

    func column(_ index: Int) -> EdgeId {
        EdgeId(bits: pixels.map { $0[index] })
    }
}

public extension CameraTile {
    init(_ description: String) {
        let lines = description.lines()
        let idScanner = Scanner(string: lines.first!)
        _ = idScanner.scanString("Tile")!
        id = idScanner.scanInt()!
        pixels = lines
            .dropFirst()
            .map { row in
                row.map { $0 == "#" }
            }
    }
}

func parseTiles(_ input: String) -> [CameraTile] {
    input.groups().map(CameraTile.init)
}

func findCornerIds(tiles: [CameraTile]) -> [Int] {
    var tilesByEdges = [EdgeId : [Int]]()
    for t in tiles {
        for e in TileEdge.allCases {
            for reversed in [false, true] {
                var row = t[e]
                if (reversed) {
                    row = row.reversed(size: t.size)
                }
                tilesByEdges[row, default: []].append(t.id)
            }
        }
    }
    let imageEdges = tilesByEdges.filter { (key, value) -> Bool in
        value.count == 1
    }
    return Dictionary(grouping: imageEdges.keys, by: { imageEdges[$0]![0] }).filter { $0.value.count == 4 }.keys.toArray()
}

public func cornerIdProduct(_ input: String) -> Int {
    findCornerIds(tiles: parseTiles(input)).product()
}

// Edges are only shared between 2 tiles
fileprivate let input = Bundle.module.text(named: "day20")

public func day20_1() -> Int {
    cornerIdProduct(input)
}

public func day20_2() -> Int {
    0
}
