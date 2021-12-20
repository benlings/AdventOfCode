import Foundation
import AdventCore

struct InfiniteImage {

    var pixels: Set<Offset>
    var background: Bit
    var xRange: ClosedRange<Int>
    var yRange: ClosedRange<Int>

    subscript(offset: Offset) -> Bit {
        if xRange.contains(offset.east) && yRange.contains(offset.north) {
            return Bit(pixels.contains(offset))
        } else {
            return background
        }
    }

    init(pixels: Set<Offset>, background: Bit = .off) {
        self.pixels = pixels
        self.background = background
        let xMinMax = self.pixels.map(\.east).minAndMax()!
        self.xRange = xMinMax.min...xMinMax.max
        let yMinMax = self.pixels.map(\.north).minAndMax()!
        self.yRange = yMinMax.min...yMinMax.max
    }

    var topLeft: Offset {
        Offset(east: xRange.lowerBound, north: yRange.lowerBound)
    }

    var bottomRight: Offset {
        Offset(east: xRange.upperBound, north: yRange.upperBound)
    }

}

public struct TrenchMap {

    var enhancementAlgorithm: [Bit]
    var image: InfiniteImage

    public mutating func enhance() {
        self.image = enhanced()
    }

    public mutating func enhance(count: Int) {
        for _ in 0..<count {
            enhance()
        }
    }

    func enhanced() -> InfiniteImage {
        var enhanced = Set<Offset>()
        for offset in OffsetRange(southWest: image.topLeft - Offset(east: 1, north: 1),
                                  northEast: image.bottomRight + Offset(east: 1, north: 1)) {
            let binary = [
                image[offset + Offset(east: -1, north: -1)],
                image[offset + Offset(east: 0, north: -1)],
                image[offset + Offset(east: 1, north: -1)],
                image[offset + Offset(east: -1, north: 0)],
                image[offset + Offset(east: 0, north: 0)],
                image[offset + Offset(east: 1, north: 0)],
                image[offset + Offset(east: -1, north: 1)],
                image[offset + Offset(east: 0, north: 1)],
                image[offset + Offset(east: 1, north: 1)],
            ]
            if Bool(enhancementAlgorithm[binary.toInt()]) {
                enhanced.insert(offset)
            }
        }
        let backgroundBinary = [Bit](repeating: image.background, count: 9)
        let background = enhancementAlgorithm[backgroundBinary.toInt()]
        return InfiniteImage(pixels: enhanced, background: background)
    }

    public var pixelCount: Int {
        image.pixels.count
    }

}

extension TrenchMap {
    public init(_ description: String) {
        let groups = description.groups()
        func read(c: Character) -> Bit { Bit(c == "#") }
        self.enhancementAlgorithm = groups[0].compactMap(read)
        self.image = InfiniteImage(pixels: Grid(groups[1], conversion: read).toSparse())
    }
}

fileprivate let day20_input = Bundle.module.text(named: "day20")

public func day20_1() -> Int {
    var map = TrenchMap(day20_input)
    map.enhance(count: 2)
    return map.pixelCount
}

public func day20_2() -> Int {
    var map = TrenchMap(day20_input)
    map.enhance(count: 50)
    return map.pixelCount
}
