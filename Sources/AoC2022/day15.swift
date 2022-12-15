import Foundation
import AdventCore

public struct BeaconSensor {
    var sensor: Offset
    var closestBeacon: Offset

    var distance: Int { sensor.manhattanDistance(to: closestBeacon) }

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
        for row in range {
            let rowRanges = sensors
                .lazy
                .filter { $0.rowRange.contains(row) }
                .map { $0.columnRange(row: row) }
                .sorted(on: \.lowerBound)
            var col = range.lowerBound
            for r in rowRanges {
                if r.contains(col) {
                    col = r.upperBound + 1
                }
            }
            if col <= range.upperBound {
                return col * 4000000 + row
            }
        }
        return 0
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


fileprivate let day15_input = Bundle.module.text(named: "day15").lines()

public func day15_1() -> Int {
    BeaconSensor.countNonBeacons(day15_input, row: 2000000)
}

public func day15_2() -> Int {
    BeaconSensor.findBeaconTuningFrequency(day15_input, range: 0...4000000)
}
