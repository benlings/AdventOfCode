import Foundation
import AdventCore

func gcd(_ m: Int, _ n: Int) -> Int {
    let r = m % n
    if r != 0 {
        return gcd(n, r)
    } else {
        return n
    }
}

func lcm(_ m: Int, _ n: Int) -> Int {
    m / gcd(m, n) * n
}

func lcm(_ values: [Int]) -> Int {
    values.reduce { lcm($0, $1) } ?? 0
}

public struct BusTimetable {
    var earliestTimestamp: Int
    var busIds: [Int?]

    func findBus() -> (busId: Int, time: Int) {
        var time = earliestTimestamp
        while true {
            let busId = busIds.compactMap { $0 }.first { i in
                time.isMultiple(of: i)
            }
            if let busId = busId {
                return (busId, time)
            }
            time += 1
        }
    }

    public func answer() -> Int {
        let (busId, time) = findBus()
        return busId * (time - earliestTimestamp)
    }

    public func earliestTimestampMatchingOffsets() -> Int {
        let requiredBusIds = busIds.enumerated().compactMap { (offset, id) -> (Int, Int)? in
            guard let busId = id else {
                return nil
            }
            return (offset, busId)
        }
        var time = 0
        while true {
            let matchingBusIds = requiredBusIds.filter { (offset, busId) in
                return (time + offset).isMultiple(of: busId)
            }.map(\.1)
            if matchingBusIds.count == requiredBusIds.count {
                return time
            }
            time += lcm(matchingBusIds)
        }
    }


}

public extension BusTimetable {
    init(_ description: String) {
        let lines = description.lines()
        earliestTimestamp = Int(lines.first!)!
        busIds = lines.last!.components(separatedBy: ",").map(Int.init)
    }
}

fileprivate let input = Bundle.module.text(named: "day13")

public func day13_1() -> Int {
    BusTimetable(input).answer()
}

public func day13_2() -> Int {
    BusTimetable(input).earliestTimestampMatchingOffsets()
}
