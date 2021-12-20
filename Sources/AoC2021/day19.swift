import Foundation
import AdventCore

public struct Offset3D : Hashable {

    var x, y, z: Int

    public init(x: Int = 0, y: Int = 0, z: Int = 0) {
        self.x = x
        self.y = y
        self.z = z
    }

}

public enum Axis3D {
    case x, y, z
}

extension Offset3D {
    subscript(axis axis: Axis3D) -> Int {
        switch axis {
        case .x: return x
        case .y: return y
        case .z: return z
        }
    }
}

public extension Offset3D {

    func rotated(angle: Int, axis: Axis3D) -> Offset3D {
        let radians = Double.pi * Double(angle)/180.0
        let s = Int(sin(radians))
        let c = Int(cos(radians))
        switch axis {
        case .x:
            return Offset3D(x: x,
                            y: y * c - z * s,
                            z: y * s + z * c)
        case .y:
            return Offset3D(x: z * s + x * c,
                            y: y,
                            z: z * c - x * s)
        case .z:
            return Offset3D(x: x * c - y * s,
                            y: x * s + y * c,
                            z: z)
        }
    }

    func allOrientations(axis: Axis3D) -> [Offset3D] {
        return [
            rotated(angle: 0, axis: axis),
            rotated(angle: 90, axis: axis),
            rotated(angle: 180, axis: axis),
            rotated(angle: 270, axis: axis),
        ]
    }

    func orientations() -> [Offset3D] {
        return [
            // Orientations around x
            (self, .x), (self.rotated(angle: 180, axis: .y), .x),
            // First move x axis to the y axis, then orientations around y
            (self.rotated(angle: 90, axis: .z), .y), (self.rotated(angle: -90, axis: .z), .y),
            // First move x axis to the z axis, then orientations around z
            (self.rotated(angle: 90, axis: .y), .z), (self.rotated(angle: -90, axis: .y), .z),
        ].flatMap { $0.allOrientations(axis: $1) }
    }

}

public extension Set where Element == Offset3D {
    func orientations() -> [Set<Offset3D>] {
        var result = [Set<Offset3D>]()
        let o = map { $0.orientations() }
        for i in o[0].indices {
            result.append(o.map { $0[i] }.toSet())
        }
        return result
    }

    func projection(axis: Axis3D) -> (Int, IndexSet) {
        let p = map { $0[axis: axis] }
        // Ensure IndexSet starts from 0
        guard let min = p.min() else { return (0, IndexSet()) }
        return (min, p.map { $0 - min }.toIndexSet())
    }
}

public extension Array where Element == Offset3D {
    func orientations() -> [[Offset3D]] {
        var result = [[Offset3D]]()
        let o = map { $0.orientations() }
        for i in o[0].indices {
            result.append(o.map { $0[i] })
        }
        return result
    }
}

public struct ScannerReadings {
    var scannerResults: [Int: Set<Offset3D>]
    var positions: [Int: Offset3D] = [:]

    var scanner0: Set<Offset3D> { scannerResults[0]! }

    func findMatches(_ first: Set<Offset3D>, _ second: Set<Offset3D>, axis: Axis3D) -> [Int] {
        let (offset0, proj0) = first.projection(axis: axis)
        var (offset1, proj1) = second.projection(axis: axis)
        let last = proj0.last!
        var dist = offset0 - offset1 + last
        proj1.shift(startingAt: 0, by: last)
        var result = [Int]()
        while !proj1.isEmpty {
            if proj0.intersection(proj1).count >= 12 {
                result.append(dist)
            }
            dist -= 1
            proj1.shift(startingAt: 0, by: -1)
        }
        return result
    }

    func findPosition(_ i: Int, axis: Axis3D) -> Int? {
        let results = scannerResults[i]!.orientations().enumerated().map {
            ($0.offset, findMatches(scanner0, $0.element, axis: axis))
        }.filter { $0.1.count > 0 }
        if results.count > 0 {
            return results[0].1[0]
        }
        return nil
    }

    public mutating func findMatches() {
        for i in scannerResults.keys.filter({ $0 != 0 }) {
            if let x = findPosition(i, axis: .x),
               let y = findPosition(i, axis: .y),
               let z = findPosition(i, axis: .z) {
                positions[i] = Offset3D(x: x, y: y, z: z)
            }
        }
    }

    public func countUniqueBeacons() -> Int {
        0
    }
}

fileprivate extension Scanner {

    func scanOffset3D() -> Offset3D? {
        if let x = scanInt(),
           let _ = scanString(","),
           let y = scanInt(),
           let _ = scanString(","),
           let z = scanInt() {
            return Offset3D(x: x, y: y, z: z)
        } else { return nil }
    }

    func scanScanner() -> (Int, Set<Offset3D>)? {
        guard let _ = scanString("--- scanner"),
              let id = scanInt(),
              let _ = scanString("---")
        else { return nil }
        var beacons = Set<Offset3D>()
        while let beacon = scanOffset3D() {
            beacons.insert(beacon)
        }
        return (id, beacons)
    }
}

public extension ScannerReadings {
    init(_ description: String) {
        self.scannerResults = description.groups().compactMap { group in
            Scanner(string: group).scanScanner()
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
    0
}
