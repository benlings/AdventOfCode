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
        case (.list(let lList), .list(let rList)):
            for (l, r) in zip(lList, rList) {
                // Exit early if not equal
                if l < r { return true }
                if l > r { return false }
            }
            // All corresponding items in list up to here are equal
            if lList.count < rList.count { return true }
            // Either r list is longer, or both equal size and equal elements
            return false
        case (.integer, .list): return .list([lhs]) < rhs
        case (.list, .integer): return lhs < .list([rhs])
        }
    }
}

struct DistressSignal {

    var packets: [(PacketData, PacketData)]

    func sumRightOrderIndexes() -> Int {
        packets.enumerated()
            .filter { $0.element.0 < $0.element.1 }
            .map { $0.offset + 1 }
            .sum()
    }

    func decoderKey() -> Int {
        var packetsWithDividers = packets.flatMap { [$0.0, $0.1] }
        let divider1 = PacketData("[[2]]")!
        let divider2 = PacketData("[[6]]")!
        packetsWithDividers.append(divider1)
        packetsWithDividers.append(divider2)
        packetsWithDividers.sort()
        return (packetsWithDividers.firstIndex(of: divider1)! + 1) * (packetsWithDividers.firstIndex(of: divider2)! + 1)
    }
}

extension DistressSignal {
    init(_ input: String) {
        packets = input.groups().map { group in
            let packets = group.lines().compactMap(PacketData.init)
            return (packets[0], packets[1])
        }
        
    }
}

public func day13_1(_ input: String) -> Int {
    DistressSignal(input).sumRightOrderIndexes()
}

public func day13_2(_ input: String) -> Int {
    DistressSignal(input).decoderKey()
}
