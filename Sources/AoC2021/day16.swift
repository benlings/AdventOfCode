import Foundation
import AdventCore
import DequeModule

extension Deque {
    mutating func takeFirst(_ n: Int) -> [Element] {
        defer { removeFirst(n) }
        return Array(prefix(n))
    }

    mutating func takeInt<I : FixedWidthInteger>(size: Int) -> I where Element == Bit {
        precondition(size < I.bitWidth)
        return takeFirst(size).toInt()
    }

    mutating func takeBit() -> Bit where Element == Bit {
        removeFirst()
    }
}

public struct Packet : Equatable {
    public var version: UInt8
    public var contents: PacketContents
}

public extension Packet {
    var versionSum: Int {
        Int(version) + contents.versionSum
    }
}

public extension PacketContents {
    var versionSum: Int {
        switch self {
        case .literal: return 0
        case .operator(_, let packets): return packets.map(\.versionSum).sum()
        }
    }

    func value() -> Int {
        switch self {
        case let .literal(n): return n
        case let .operator(t, ps): return t.operation(ps.map { $0.contents.value() })
        }
    }
}

public enum PacketType: UInt8 {
    case sum = 0
    case product = 1
    case minimum = 2
    case maximum = 3
    case literal = 4
    case greaterThan = 5
    case lessThan = 6
    case equalTo = 7
}

extension PacketType {
    var operation: ([Int]) -> Int {
        switch self {
        case .sum: return { $0.sum() }
        case .product: return { $0.product() }
        case .minimum: return { $0.min()! }
        case .maximum: return { $0.max()! }
        case .literal: fatalError()
        case .greaterThan: return { $0[0] > $0[1] ? 1 : 0 }
        case .lessThan: return { $0[0] < $0[1] ? 1 : 0 }
        case .equalTo: return { $0[0] == $0[1] ? 1 : 0 }
        }
    }
}

public enum PacketContents : Equatable {
    case literal(Int)
    case `operator`(PacketType, [Packet])
}

extension Packet {

    public init(binary: [Bit]) {
        var b = Deque(binary)
        self = .init(consuming: &b)
    }

    init(consuming b: inout Deque<Bit>) {
        self.version = b.takeInt(size: 3)
        let rawType = b.takeInt(size: 3) as UInt8
        let typeId = PacketType(rawValue: rawType)!
        if typeId == .literal {
            var number = [Bit]()
            while b.takeBit() == .on {
                number.append(contentsOf: b.takeFirst(4))
            }
            number.append(contentsOf: b.takeFirst(4))
            self.contents = .literal(number.toInt())
        } else {
            let lengthTypeId = b.takeBit()
            switch lengthTypeId {
            case .off:
                let bitLength = b.takeInt(size: 15) as UInt16
                let targetCount = b.count - Int(bitLength)
                var subPackets = [Packet]()
                while (b.count > targetCount) {
                    subPackets.append(Packet(consuming: &b))
                }
                assert(b.count == targetCount)
                self.contents = .operator(typeId, subPackets)
            case .on:
                let subPacketsCount = b.takeInt(size: 11) as UInt16
                self.contents = .operator(typeId, (0..<subPacketsCount).map { _ in Packet(consuming: &b) })
            }
        }
    }
}

fileprivate let day16_input = Bundle.module.text(named: "day16").lines()[0]

public func day16_1() -> Int {
    Packet(binary: Array(hex: day16_input)).versionSum
}

public func day16_2() -> Int {
    Packet(binary: Array(hex: day16_input)).contents.value()
}
