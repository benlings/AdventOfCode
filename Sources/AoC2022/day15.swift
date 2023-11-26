import Foundation
import AdventCore

struct BeaconSensor {
    var sensor: Offset
    var closestBeacon: Offset

    var distance: Int { sensor.manhattanDistance(to: closestBeacon) }

    func canDetect(_ point: Offset) -> Bool {
        sensor.manhattanDistance(to: point) <= distance
    }

    var rowRange: ClosedRange<Int> { (sensor.north - distance)...(sensor.north + distance) }

    func columnRange(row: Int) -> ClosedRange<Int> {
        let extent = distance - abs(sensor.north - row)
        return (sensor.east - extent)...(sensor.east + extent)
    }

    public static func countNonBeacons(_ input: some Sequence<String>, row: Int) -> Int {
        let sensors = input.compactMap(Self.init).filter { $0.rowRange.contains(row) }
        let knownBeacons = sensors.filter { $0.closestBeacon.north == row }.map(\.closestBeacon.east).toSet()
        var nonBeacons = Set<Int>()
        for sensor in sensors {
            nonBeacons.formUnion(sensor.columnRange(row: row))
        }
        nonBeacons.subtract(knownBeacons)
        return nonBeacons.count
    }

    public static func findBeaconTuningFrequency(_ input: some Sequence<String>, range: ClosedRange<Int>) -> Int {
        let sensors = input.compactMap(Self.init)

        // Only one sensor location, so it must be immediately adjacent to boundary of sensor visibility
        // Find all intersections of the lines just outside the boundaries and then filter the ones that aren't
        // detectable by any sensor
        let lines = sensors.flatMap { s -> [(m: Int, c: Int)] in
            [ // y = mx + c => c = y - mx
                (m: 1, c: s.sensor.north - s.sensor.east + s.distance + 1),
                (m: 1, c: s.sensor.north - s.sensor.east - s.distance - 1),
                (m: -1, c: s.sensor.north + s.sensor.east + s.distance + 1),
                (m: -1, c: s.sensor.north + s.sensor.east - s.distance - 1),
            ]
        }

        // Intersections:
        // m1 x + c1 = m2 x + c2 => x = (c2 - c1)/(m1 - m2)
        // y = m1 x + c1
        let intersections = lines.permutations(ofCount: 2).compactMap { combo -> Offset? in
            let (m1, c1) = combo[0], (m2, c2) = combo[1]
            if m1 == m2 { return nil }
            let x = (c2 - c1)/(m1 - m2)
            let y = (m1 * (c2 - c1))/(m1 - m2) + c1
            return range.contains(x) && range.contains(y) ? Offset(east: x, north: y) : nil
        }.toSet()

        let point = intersections.first { point in
            !sensors.contains { s in s.canDetect(point) }
        }!
        return point.east * 4_000_000 + point.north
    }
}

// Sensor at x=2, y=18: closest beacon is at x=-2, y=15

extension BeaconSensor {
    init?(_ input: String) {
        let scanner = Scanner(string: input)
        guard let _ = scanner.scanString("Sensor at x="),
              let x = scanner.scanInt(),
              let _ = scanner.scanString(", y="),
              let y = scanner.scanInt(),
              let _ = scanner.scanString(": closest beacon is at x="),
              let beaconX = scanner.scanInt(),
              let _ = scanner.scanString(", y="),
              let beaconY = scanner.scanInt()
        else { return nil }
        sensor = Offset(east: x, north: y)
        closestBeacon = Offset(east: beaconX, north: beaconY)
    }
}


public func day15_1(_ input: [String], row: Int) -> Int {
    BeaconSensor.countNonBeacons(input, row: row)
}

public func day15_2(_ input: [String], range: ClosedRange<Int>) -> Int {
    BeaconSensor.findBeaconTuningFrequency(input, range: range)
}
