import Foundation
import AdventCore

public indirect enum SnailfishNumber : Equatable {
    case pair(SnailfishNumber, SnailfishNumber)
    case regular(Int)
}

public extension SnailfishNumber {

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
                lhs.addFirst(n: l)
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
            lhs.addFirst(n: n)
            self = .pair(lhs, rhs)
        case let .regular(i):
            self = .regular(i + n)
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
}

fileprivate let day18_input = Bundle.module.text(named: "day18").lines()

public func day18_1() -> Int {
    0
}

public func day18_2() -> Int {
    0
}
