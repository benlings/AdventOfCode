import Foundation
import AdventCore

public struct TrenchMap {

    var enhancementAlgorithm: [Bit]
    var image: Set<Offset>

    public mutating func enhance() {
        self.image = enhanced()
    }

    func enhanced() -> Set<Offset> {
        var enhanced = Set<Offset>()
        for offset in OffsetRange(southWest: image.topLeft - Offset(east: 1, north: 1),
                                  northEast: image.bottomRight + Offset(east: 1, north: 1)) {
            let binary = [
                Bit(image.contains(offset + Offset(east: -1, north: -1))),
                Bit(image.contains(offset + Offset(east: 0, north: -1))),
                Bit(image.contains(offset + Offset(east: 1, north: -1))),
                Bit(image.contains(offset + Offset(east: -1, north: 0))),
                Bit(image.contains(offset + Offset(east: 0, north: 0))),
                Bit(image.contains(offset + Offset(east: 1, north: 0))),
                Bit(image.contains(offset + Offset(east: -1, north: 1))),
                Bit(image.contains(offset + Offset(east: 0, north: 1))),
                Bit(image.contains(offset + Offset(east: 1, north: 1))),
            ]
            if Bool(enhancementAlgorithm[binary.toInt()]) {
                enhanced.insert(offset)
            }
        }
        return enhanced
    }

    public var pixelCount: Int {
        image.count
    }

}

extension TrenchMap {
    public init(_ description: String) {
        let groups = description.groups()
        func read(c: Character) -> Bit { Bit(c == "#") }
        self.enhancementAlgorithm = groups[0].compactMap(read)
        self.image = Grid(groups[1], conversion: read).toSparse()
    }
}

fileprivate let day20_input = Bundle.module.text(named: "day20")

public func day20_1() -> Int {
    0
}

public func day20_2() -> Int {
    0
}
