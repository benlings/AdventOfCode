import Foundation
import AdventCore

struct BusTimetable {
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

    func answer() -> Int {
        let (busId, time) = findBus()
        return busId * (time - earliestTimestamp)

    }
}

extension BusTimetable {
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
    0
}
