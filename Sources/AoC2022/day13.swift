import Foundation
import AdventCore
import SE0270_RangeSet

fileprivate extension Scanner {
    func scanPacketData() -> PacketData? {
        if let _ = scanString("[") {
            var contents = [PacketData]()
            while let d = scanPacketData() {
                contents.append(d)
                if scanString("]") != nil {
                    break
                }
                _ = scanString(",")
            }
            return .list(contents)
        } else if let i = scanInt() {
            return .integer(i)
        } else {
            return nil
        }
    }
}

enum PacketData : Equatable {
    case integer(Int)
    case list([PacketData])
}

extension PacketData {
    init?(_ input: String) {
        let scanner = Scanner(string: input)
        guard let s = scanner.scanPacketData() else { return nil }
        self = s
    }
}

extension PacketData : Comparable {
    static func < (lhs: PacketData, rhs: PacketData) -> Bool {
        switch (lhs, rhs) {
        case (.integer(let l), .integer(let r)): return l < r
        case (.list(let l), .list(let r)):
            for i in 0..<(max(l.count, r.count)) {
                if i >= l.count {
                    return true
                }
                if i >= r.count {
                    return false
                }
                if l[i] < r[i] {
                    return true
                }
                if l[i] > r[i] {
                    return false
                }
            }
            return false
        case (.integer(let l), .list(let r)): return .list([.integer(l)]) < .list(r)
        case (.list(let l), .integer(let r)): return .list(l) < .list([.integer(r)])
        }
    }
}

public struct DistressSignal {

    var packets: [(PacketData, PacketData)]

    public func sumRightOrderIndexes() -> Int {
        packets.enumerated()
            .filter { $0.element.0 < $0.element.1 }
            .map { $0.offset + 1 }
            .sum()
    }

    public func decoderKey() -> Int {
        var packetsWithDividers = packets.flatMap { [$0.0, $0.1] }
        let divider1 = PacketData("[[2]]")!
        let divider2 = PacketData("[[6]]")!
        packetsWithDividers.append(divider1)
        packetsWithDividers.append(divider2)
        packetsWithDividers.sort()
        return (packetsWithDividers.firstIndex(of: divider1)! + 1) * (packetsWithDividers.firstIndex(of: divider2)! + 1)
    }
}

public extension DistressSignal {
    init(_ input: String) {
        packets = input.groups().map { group in
            let packets = group.lines().compactMap(PacketData.init)
            return (packets[0], packets[1])
        }
        
    }
}

fileprivate let day13_input = Bundle.module.text(named: "day13")

public func day13_1() -> Int {
    DistressSignal(day13_input).sumRightOrderIndexes()
}

public func day13_2() -> Int {
    DistressSignal(day13_input).decoderKey()
}
