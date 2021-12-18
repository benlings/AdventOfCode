import Foundation
import AdventCore

public indirect enum SnailfishNumber : Equatable {
    case pair(SnailfishNumber, SnailfishNumber)
    case regular(Int)
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
