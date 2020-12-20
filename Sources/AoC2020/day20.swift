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

public enum TileEdge : Hashable, CaseIterable {
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

public struct TiledImage {
    var sourceTiles: [CameraTile]

    struct TileOrientation: Hashable {
        var tileId: Int
        var topEdge: TileEdge
        var flipped: Bool
    }

    var tilesByEdges: [EdgeId : [TileOrientation]] {
        var tilesByEdges = [EdgeId : [TileOrientation]]()
        for tile in sourceTiles {
            for edge in TileEdge.allCases {
                for reversed in [false, true] {
                    var edgeId = tile[edge]
                    if (reversed) {
                        edgeId = edgeId.reversed(size: tile.size)
                    }
                    tilesByEdges[edgeId, default: []].append(TileOrientation(tileId: tile.id, topEdge: edge, flipped: reversed))
                }
            }
        }
        return tilesByEdges
    }

    func findCornerIds() -> [Int] {
        let imageEdges = self.tilesByEdges.filter { (key, value) -> Bool in
            value.count == 1
        }
        return Dictionary(grouping: imageEdges.keys, by: { imageEdges[$0]![0].tileId }).filter { $0.value.count == 4 }.keys.toArray()
    }

    public func cornerIdProduct() -> Int {
        findCornerIds().product()
    }
}

public extension TiledImage {
    init(_ input: String) {
        sourceTiles = input.groups().map(CameraTile.init)
    }
}

// Edges are only shared between 2 tiles
fileprivate let input = Bundle.module.text(named: "day20")

public func day20_1() -> Int {
    TiledImage(input).cornerIdProduct()
}

public func day20_2() -> Int {
    0
}
