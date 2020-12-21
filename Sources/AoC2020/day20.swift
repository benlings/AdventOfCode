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

public enum TileEdge : Int8, Hashable, CaseIterable {
    case top, right, bottom, left

    func edge(inDirection edge: TileEdge, reversed: Bool) -> TileEdge {
        return TileEdge(rawValue: (self.rawValue + edge.rawValue) % 4)!
    }

    var opposite: TileEdge {
        return TileEdge(rawValue: (self.rawValue + 2) % 4)!
    }
}

public struct CameraTile {
    public var id: Int
    var pixels: [[Bool]]
    public var size: Int {
        pixels.count
    }

    // Edges are least significant bit on right-most/bottom-most ends
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

extension CameraTile : CustomStringConvertible {
    public var description: String {
        let p = pixels.map { $0.map { $0 ? "#" : "." }.joined() }.joined(separator: "\n")
        return "Tile \(id):\n\(p)"
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

func rotateClockwise<T>(matrix: inout [[T]]) {
    let old = matrix
    for i in matrix.indices {
        for j in matrix[i].indices {
            matrix[i][j] = old[matrix.count - 1 - j][i];
        }
    }
}

public struct TiledImage {
    var sourceTiles: [CameraTile]

    struct OrientedTile {
        var tile: CameraTile
        var identifiedEdge: TileEdge
        var flipped: Bool

        func edgeId(fromDirection fromEdge: TileEdge, inDirection edge: TileEdge) -> EdgeId {
            let resolvedDirection = identifiedEdge.edge(inDirection: edge, reversed: flipped)
            var edgeId = tile[resolvedDirection]
            if (flipped) {
                edgeId = edgeId.reversed(size: tile.size)
            }
            return edgeId
        }

        func rotatedTile(identifiedEdgeInPosition edge: TileEdge) -> CameraTile {
            let rotationCount = (4 + edge.rawValue - identifiedEdge.rawValue) % 4
            var newPixels = self.tile.pixels
            for _ in 0..<rotationCount {
                rotateClockwise(matrix: &newPixels)
            }
            // todo handle flipped
            return CameraTile(id: tile.id, pixels:newPixels)
        }
    }

    var tilesByEdges: [EdgeId : [OrientedTile]] {
        var tilesByEdges = [EdgeId : [OrientedTile]]()
        for tile in sourceTiles {
            for edge in TileEdge.allCases {
                for reversed in [false, true] {
                    var edgeId = tile[edge]
                    if (reversed) {
                        edgeId = edgeId.reversed(size: tile.size)
                    }
                    tilesByEdges[edgeId, default: []].append(OrientedTile(tile: tile, identifiedEdge: edge, flipped: reversed))
                }
            }
        }
        return tilesByEdges
    }

    func findCornerIds() -> [Int] {
        let imageEdges = self.tilesByEdges.filter { (key, value) -> Bool in
            value.count == 1
        }.mapValues { $0[0] }
        return Dictionary(grouping: imageEdges.keys, by: { imageEdges[$0]!.tile.id }).filter { $0.value.count == 4 }.keys.toArray()
    }

    func tileArrangement() -> [[CameraTile]] {
        var tilesById = sourceTiles.map { ($0.id, $0) }.toDictionary()
        let tilesByEdge = self.tilesByEdges
        // Pick corner - define it as the origin - with no rotation and not inverted
        let originTile = tilesById[findCornerIds().first!]!
        // Remove from remaining tiles
        tilesById.removeValue(forKey: originTile.id)
        // Find orientation - it will only have adjacent tiles on 2 edges
        // we need to iterate in these 2 directions to find the rest of the tils
        let innerEdges = TileEdge.allCases.filter { edge in
            tilesByEdge[originTile[edge]]!.filter { $0.tile.id != originTile.id }.isEmpty == false
        }
        func nextTile(from tile: CameraTile, inDirection edge: TileEdge) -> CameraTile? {
            let nextEdgeId = tile[edge]
            guard let orientedTile = tilesByEdge[nextEdgeId]?.first(where: { $0.tile.id != tile.id }) else {
                return nil
            }
            let nextTile = orientedTile.rotatedTile(identifiedEdgeInPosition: edge.opposite)
            return nextTile
        }
        var r = [[OrientedTile]]()
        var currentTile = originTile
        currentTile = nextTile(from: currentTile, inDirection: innerEdges[1])!
        currentTile = nextTile(from: currentTile, inDirection: innerEdges[1])!
        currentTile = nextTile(from: currentTile, inDirection: innerEdges[1])!
        currentTile = nextTile(from: currentTile, inDirection: innerEdges[1])!
        currentTile = nextTile(from: currentTile, inDirection: innerEdges[1])!
        currentTile = nextTile(from: currentTile, inDirection: innerEdges[1])!
        currentTile = nextTile(from: currentTile, inDirection: innerEdges[1])!

        return [[originTile]]
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
    TiledImage(input).tileArrangement()[0][0].id
}
