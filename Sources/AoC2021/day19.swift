import Foundation
import AdventCore

public extension Array<Offset3D> {
    func orientations() -> [[Offset3D]] {
        var result = [[Offset3D]]()
        let o = map { $0.orientations() }
        for i in o[0].indices {
            result.append(o.map { $0[i] })
        }
        return result
    }
}

struct ScannerReport {
    var beacons: Set<Offset3D>
    var position = Offset3D()

    func orientations() -> [Set<Offset3D>] {
        var result = [Set<Offset3D>]()
        let o = beacons.map { $0.orientations() }
        for i in o[0].indices {
            result.append(o.map { $0[i] }.toSet())
        }
        return result
    }

    mutating func orient(_ i: Int) {
        beacons = orientations()[i]
    }

}

public struct ScannerReadings {
    var scannerResults: [Int: ScannerReport]

    var scanner0: ScannerReport { scannerResults[0]! }
    var oriented = [0] as Set

    func findMatches(_ first: Set<Offset3D>, _ second: Set<Offset3D>, axis: Axis3D) -> [Int] {
        let (offset0, proj0) = first.projection(axis: axis)
        var (offset1, proj1) = second.projection(axis: axis)
        let last = proj0.last!
        var dist = offset0 - offset1 + last
        proj1.shift(startingAt: 0, by: last)
        var result = [Int]()
        while !proj1.isEmpty {
            if proj0.intersection(proj1).count >= 10 {
                result.append(dist)
            }
            dist -= 1
            proj1.shift(startingAt: 0, by: -1)
        }
        return result
    }

    func findPosition(from: ScannerReport, to i: Int, axis: Axis3D) -> (orientations: Set<Int>, offset: Int)? {
        let results = scannerResults[i]!.orientations().enumerated().map {
            (orientation: $0.offset, matches: findMatches(from.beacons, $0.element, axis: axis))
        }.filter { $0.matches.count > 0 }
        if results.count > 0 {
            let offsets = results.flatMap(\.matches).toSet()
            assert(offsets.count == 1)
            return (orientations: results.map(\.orientation).toSet(), offset: offsets.first!)
        }
        return nil
    }

    public mutating func findMatches() {
        var searched = Set<Int>()
        var toSearch = [0] as Set
        while let j = toSearch.popFirst() {
            let fromScanner = scannerResults[j]!
            for i in scannerResults.keys.filter({ $0 != j && !oriented.contains($0) }) {
                if let x = findPosition(from: fromScanner, to: i, axis: .x),
                   let y = findPosition(from: fromScanner, to: i, axis: .y),
                   let z = findPosition(from: fromScanner, to: i, axis: .z) {
                    let orientations = x.orientations.intersection(y.orientations).intersection(z.orientations)
                    assert(orientations.count == 1)
                    let orientation = orientations.first!
                    self.scannerResults[i]?.position = fromScanner.position + Offset3D(x: x.offset, y: y.offset, z: z.offset)
                    self.scannerResults[i]?.orient(orientation)
                    self.oriented.insert(i)
                }
            }
            searched.insert(j)
            toSearch.formUnion(oriented.subtracting(searched))
        }
    }

    public func countUniqueBeacons() -> Int {
        scannerResults.values.flatMap { report in
            report.beacons.map { $0 + report.position }
        }.toSet().count
    }

    public var maxScannerDistance: Int {
        scannerResults.values
            .combinations(ofCount: 2)
            .map { $0[0].position.manhattanDistance(to: $0[1].position) }
            .max()!
    }
}

fileprivate extension Scanner {

    func scanScannerReport() -> (Int, ScannerReport)? {
        guard let _ = scanString("--- scanner"),
              let id = scanInt(),
              let _ = scanString("---")
        else { return nil }
        var beacons = Set<Offset3D>()
        while let beacon = scanOffset3D() {
            beacons.insert(beacon)
        }
        return (id, ScannerReport(beacons: beacons))
    }
}

public extension ScannerReadings {
    init(_ description: String) {
        self.scannerResults = description.groups().compactMap { group in
            Scanner(string: group).scanScannerReport()
        }.toDictionary()
    }
}

fileprivate let day19_input = Bundle.module.text(named: "day19")

public func day19_1() -> Int {
    var readings = ScannerReadings(day19_input)
    readings.findMatches()
    return readings.countUniqueBeacons()
}

public func day19_2() -> Int {
    var readings = ScannerReadings(day19_input)
    readings.findMatches()
    return readings.maxScannerDistance
}
