import Foundation
import AdventCore

public indirect enum SnailfishNumber : Equatable {
    case pair(SnailfishNumber, SnailfishNumber)
    case regular(Int)
}

public extension SnailfishNumber {

    func reduced() -> SnailfishNumber {
        var number = self;
        number.reduce()
        return number
    }

    mutating func reduce() {
        while reduceAction() {
            // nothing
        }
    }

    mutating func reduceAction() -> Bool {
        explodeFirst() || splitFirst()
    }

    mutating func explodeFirst() -> Bool {
        explodeFirst(depth: 1) != nil
    }

    mutating func explodeFirst(depth: Int) -> (Int?, Int?)? {
        if depth > 4, case let .pair(.regular(lhs), .regular(rhs)) = self {
            self = .regular(0)
            return (lhs, rhs)
        }
        switch self {
        case var .pair(lhs, rhs):
            switch lhs.explodeFirst(depth: depth + 1) {
            case let (l, r?)?:
                rhs.addFirst(n: r)
                self = .pair(lhs, rhs)
                return (l, nil)
            case let (l, nil)?:
                self = .pair(lhs, rhs)
                return (l, nil)
            case nil: break
            }
            switch rhs.explodeFirst(depth: depth + 1) {
            case let (l?, r)?:
                lhs.addLast(n: l)
                self = .pair(lhs, rhs)
                return (nil, r)
            case let (nil, r)?:
                self = .pair(lhs, rhs)
                return (nil, r)
            case nil: break
            }
        case .regular: break
        }
        return nil
    }

    mutating func addFirst(n: Int) {
        switch self {
        case .pair(var lhs, let rhs):
            // Only go down left branch - if there's a pair, it will have a number in it
            lhs.addFirst(n: n)
            self = .pair(lhs, rhs)
        case let .regular(i):
            self = .regular(i + n)
        }
    }

    mutating func addLast(n: Int) {
        switch self {
        case .pair(let lhs, var rhs):
            // Only go down right branch - if there's a pair, it will have a number in it
            rhs.addLast(n: n)
            self = .pair(lhs, rhs)
        case let .regular(i):
            self = .regular(i + n)
        }
    }

    mutating func splitFirst() -> Bool {
        switch self {
        case let .regular(i) where i > 9:
            let half = i / 2
            self = .pair(.regular(half), .regular(i - half))
            return true
        case var .pair(lhs, rhs):
            if lhs.splitFirst() || rhs.splitFirst() {
                self = .pair(lhs, rhs)
                return true
            }
        case .regular:
            break
        }
        return false
    }

    var magnitude: Int {
        switch self {
        case let .pair(lhs, rhs): return 3 * lhs.magnitude + 2 * rhs.magnitude
        case let .regular(i): return i
        }
    }
}

fileprivate extension Scanner {
    func scanSnailfishNumber() -> SnailfishNumber? {
        let i = currentIndex
        if let _ = scanString("["),
           let first = scanIntOrSnailFish(),
           let _ = scanString(","),
           let second = scanIntOrSnailFish(),
           let _ = scanString("]") {
            return .pair(first, second)
        } else {
            currentIndex = i
            return nil
        }
    }
    func scanIntOrSnailFish() -> SnailfishNumber? {
        if let number = scanInt() {
            return .regular(number)
        } else {
            return scanSnailfishNumber()
        }
    }
}

extension SnailfishNumber : CustomStringConvertible {
    public var description: String {
        switch self {
        case let .pair(lhs, rhs): return "[\(lhs.description),\(rhs.description)]"
        case let .regular(i): return i.description
        }
    }
}

public extension SnailfishNumber {
    init(_ description: String) {
        let scanner = Scanner(string: description)
        self = scanner.scanSnailfishNumber()!
    }
    static func + (lhs: Self, rhs: Self) -> Self {
        let result = Self.pair(lhs, rhs)
        return result.reduced()
    }

    static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }

    static func numbers(_ lines: [String]) -> [SnailfishNumber] {
        lines.map(SnailfishNumber.init)
    }

    static func sum(_ lines: [String]) -> SnailfishNumber? {
        numbers(lines).reduce(+)
    }

    static func largestPairMagnitude(_ lines: [String]) -> Int? {
        numbers(lines).permutations(ofCount: 2).map { pair in
            (pair[0] + pair[1]).magnitude
        }.max()
    }

}

fileprivate let day18_input = Bundle.module.text(named: "day18").lines()

public func day18_1() -> Int {
    SnailfishNumber.sum(day18_input)!.magnitude
}

public func day18_2() -> Int {
    SnailfishNumber.largestPairMagnitude(day18_input)!
}
