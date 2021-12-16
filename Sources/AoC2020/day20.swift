import Foundation
import AdventCore

public typealias EdgeId = UInt16

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
        let p = pixels.map { $0.map { $0 ? "#" : "." }.joined() }.lines()
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

public struct CameraImage {
    var pixels: [[Bool]]

    var width: Int {
        pixels[0].count
    }

    var height: Int {
        pixels.count
    }

    subscript(x: Int, y: Int) -> Bool {
        get {
            pixels[y][x]
        }
        set {
            pixels[y][x] = newValue
        }
    }

    func find(occurrencesOf image: CameraImage) -> [(x: Int, y: Int)] {
        (0...(width - image.width)).flatMap { x in
            (0...(height - image.height)).map { y in
                (x: x, y: y)
            }
        }.filter { coord in
            matches(image: image, at: coord.x, y: coord.y)
        }
    }

    func matches(image: CameraImage, at xOffset: Int, y yOffset: Int) -> Bool {
        for x in 0..<image.width {
            for y in 0..<image.height {
                if image[x, y] && !self[xOffset + x, yOffset + y] {
                    return false
                }
            }
        }
        return true
    }

    mutating func subtract(image: CameraImage, at xOffset: Int, y yOffset: Int) {
        for x in 0..<image.width {
            for y in 0..<image.height {
                if image[x, y] {
                    self[xOffset + x, yOffset + y] = false
                }
            }
        }
    }

    func countSetPixels() -> Int {
        pixels.map { $0.map { $0 ? 1 : 0 }.sum() }.sum()
    }

}

extension CameraImage : CustomStringConvertible {
    public var description: String {
        pixels.map { $0.map { $0 ? "#" : "." }.joined() }.lines()
    }
}

public extension CameraImage {
    init(_ description: String) {
        pixels = description.lines()
            .map { row in
                row.map { $0 == "#" }
            }
    }

    static let seaMonster = CameraImage("""
                                  #.
                #    ##    ##    ###
                 #  #  #  #  #  #...
                """)
}

extension CameraImage {
    init(tiles: [[CameraTile]]) {
        pixels = [[Bool]]()
        var insetTiles = tiles
        for y in insetTiles.indices {
            for x in insetTiles[y].indices {
                insetTiles[y][x].pixels.removeEdges()
            }
        }
        for row in insetTiles {
            var tileRows = [[Bool]](repeating: [Bool](), count: row[0].pixels.count)
            for i in row[0].pixels.indices {
                for tile in row {
                    tileRows[i].append(contentsOf: tile.pixels[i])
                }
            }
            pixels.append(contentsOf: tileRows)
        }
    }
}

fileprivate extension Array where Element == [Bool] {

    mutating func rotateClockwise() {
        let old = self
        for i in self.indices {
            for j in self[i].indices {
                self[i][j] = old[self.count - 1 - j][i];
            }
        }
    }

    mutating func flipVertical() {
        self.reverse()
    }

    mutating func flipHorizontal() {
        for i in indices {
            self[i].reverse()
        }
    }

    mutating func removeEdges() {
        self.removeFirst()
        self.removeLast()
        for i in indices {
            self[i].removeFirst()
            self[i].removeLast()
        }
    }
}

public struct TiledImage {
    var sourceTiles: [CameraTile]

    struct OrientedTile {
        var tile: CameraTile
        var identifiedEdge: TileEdge
        var flipped: Bool

        func rotatedTile(movingIdentifiedEdgeTo edge: TileEdge) -> CameraTile {
            let rotationCount = (4 + edge.rawValue - identifiedEdge.rawValue) % 4
            var newPixels = self.tile.pixels
            for _ in 0..<rotationCount {
                newPixels.rotateClockwise()
            }
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

    public func tileArrangement() -> [[CameraTile]] {
        let tilesById = sourceTiles.map { ($0.id, $0) }.toDictionary()
        let tilesByEdge = self.tilesByEdges
        // Find tile to use as origin. Needs to be oriented so that top and left edges are empty
        // return array has this in [0][0]
        var originTile = findCornerIds()
                    .map { tilesById[$0]! }
                    .first {
                        tilesByEdge[$0[.top]]!.count == 1
                    }!
        // Orient tile - if it doesn't have a tile to the right, we need to flip it
        if tilesByEdge[originTile[.right]]!.filter({ $0.tile.id != originTile.id }).isEmpty {
            originTile.pixels.flipHorizontal()
        }
        func nextTile(from tile: CameraTile, inDirection edge: TileEdge) -> CameraTile? {
            let nextEdgeId = tile[edge]
            guard let orientedTile = tilesByEdge[nextEdgeId]?.first(where: { $0.tile.id != tile.id }) else {
                return nil
            }
            var nextTile = orientedTile.rotatedTile(movingIdentifiedEdgeTo: edge.opposite)
            // Flip tile if the edges don't line up when rotated
            if nextTile[edge.opposite] != nextEdgeId {
                switch (edge) {
                case .bottom, .top:
                    nextTile.pixels.flipHorizontal()
                case .left, .right:
                    nextTile.pixels.flipVertical()
                }
            }
            return nextTile
        }
        var rows = [[CameraTile]]()
        var currentRowTile = originTile as CameraTile?
        while true {
            guard let rowTile = currentRowTile else { break }
            var row = [CameraTile]()
            var currentTile = rowTile as CameraTile?
            while true {
                guard let tile = currentTile else { break }
                row.append(tile)
                currentTile = nextTile(from: tile, inDirection: .right)
            }
            rows.append(row)
            currentRowTile = nextTile(from: rowTile, inDirection: .bottom)
        }
        return rows
    }

    public func mergeTiles() -> CameraImage {
        let tiles = tileArrangement()
        return CameraImage(tiles: tiles)
    }

    public func cornerIdProduct() -> Int {
        findCornerIds().product()
    }

    public func findSeaMonsters() -> (CameraImage, [(x: Int, y: Int)]) {
        var image = mergeTiles()
        let monster = CameraImage.seaMonster
        for _ in 0..<2 {
            for _ in 0..<4 {
                let offsets = image.find(occurrencesOf: monster)
                if offsets.count > 0 {
                    return (image, offsets)
                }
                image.pixels.rotateClockwise()
            }
            image.pixels.flipVertical()
        }
        return (image, [])
    }

    public func waterRoughness() -> Int {
        let seaMonsters = findSeaMonsters()
        var image = seaMonsters.0
        for (x, y) in seaMonsters.1 {
            image.subtract(image: CameraImage.seaMonster, at: x, y: y)
        }
        return image.countSetPixels()
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
    TiledImage(input).waterRoughness()
}
