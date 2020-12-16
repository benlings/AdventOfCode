import Foundation
import AdventCore

func gcd<I>(_ m: I, _ n: I) -> I where I : BinaryInteger {
    let r = m % n
    if r != 0 {
        return gcd(n, r)
    } else {
        return n
    }
}

func lcm<I>(_ m: I, _ n: I) -> I where I : BinaryInteger {
    m / gcd(m, n) * n
}

extension Array where Element : BinaryInteger {
    func lcm() -> Element? {
        reduce(AoC2020.lcm)
    }
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
            id.map { (offset, $0) }
        }
        var time = 0
        while true {
            let matchingBusIds = requiredBusIds.filter { (offset, busId) in
                (time + offset).isMultiple(of: busId)
            }.map(\.1)
            if matchingBusIds.count == requiredBusIds.count {
                return time
            }
            time += matchingBusIds.lcm() ?? 1
        }
    }
}

public extension BusTimetable {
    init(_ description: String) {
        let lines = description.lines()
        earliestTimestamp = Int(lines.first!)!
        busIds = lines.last!.commaSeparated().map(Int.init)
    }
}

fileprivate let input = Bundle.module.text(named: "day13")

public func day13_1() -> Int {
    BusTimetable(input).answer()
}

public func day13_2() -> Int {
    BusTimetable(input).earliestTimestampMatchingOffsets()
}
