import Foundation
import AdventCore

public indirect enum MessageRule : Equatable {
    case character(Character)
    case consecutive([Int])
    case alternative(MessageRule, MessageRule)
}

public struct MessageRules {
    public var rules: [Int : MessageRule]

    public func match2(_ text: String) -> Bool {
        var mutated = self;
        for c8 in 1...5 {
            for c11 in 1...5 {
                mutated.updateRule8(count: c8)
                mutated.updateRule11(count: c11)
                if mutated.match(text) {
//                    if c8 != 1 && c11 != 1 {
//                        print("\(text) matched with mutations 8: \(c8) & 11: \(c11)")
//                    }
                    return true
                }
            }
        }
        return false
    }

    public func match(_ text: String) -> Bool {
        let scanner = Scanner(string: text)
        return match(rule: rules[0]!, scanner: scanner) && scanner.isAtEnd
    }

    func match(rule: MessageRule, scanner: Scanner) -> Bool {
        switch rule {
        case .character(let c):
            return scanner.scanCharacter().map { $0 == c } ?? false
        case .consecutive(let nums):
            return nums.allSatisfy {
                match(rule: rules[$0]!, scanner: scanner)
            }
        case .alternative(let first, let second):
            let i = scanner.currentIndex
            if match(rule: first, scanner: scanner) {
                return true
            }
            scanner.currentIndex = i
            if match(rule: second, scanner: scanner) {
                return true
            }
            return false
        }
    }

    public mutating func updateRule8(count: Int) {
        // 8: 42 | 42 8
        rules[8] = .consecutive(Array(repeating: 42, count: count))
    }

    public mutating func updateRule11(count: Int) {
        // 11: 42 31 | 42 11 31
        var a = [Int]()
        for i in 0..<count {
            a.insert(contentsOf: [42, 31], at: i)
        }
        rules[11] = .consecutive(a)
    }
}

public extension MessageRules {
    init(_ description: String) {
        rules = description.lines().map { line in
            let s = Scanner(string: line)
            let num = s.scanInt()!
            let _ = s.scanString(":")
            let rule = s.scanRule()!
            return (num, rule)
        }.toDictionary()
    }
}

public func countValidMessages(_ input: String, p2: Bool = false) -> Int {
    let groups = input.groups()
    let rules = MessageRules(groups[0])
    return groups[1]
        .lines()
        .count { p2 ? rules.match2($0) : rules.match($0) }
}

// rule = consecutive | alternative | character
// consecutive = { int }
// alternative = consecutive "|" consecutive
// character = '"' c '"'

fileprivate extension Scanner {

    func scanRule() -> MessageRule? {
        if let a = scanAlternative() {
            return a
        } else if let c = scanConsecutive() {
            return c
        } else if let c = scanQuotedCharacter() {
            return c
        } else {
            return nil
        }
    }

    func scanQuotedCharacter() -> MessageRule? {
        let i = currentIndex
        guard let _ = scanString("\""),
              let c = scanCharacter(),
              let _ = scanCharacter() else {
            currentIndex = i
            return nil
        }
        return .character(c)
    }

    func scanConsecutive() -> MessageRule? {
        guard let first = scanInt() else { return nil }
        var r = [first]
        while let next = scanInt() {
            r.append(next)
        }
        return .consecutive(r)
    }

    func scanAlternative() -> MessageRule? {
        let i = currentIndex
        guard let first = scanConsecutive(),
              let _ = scanString("|"),
              let second = scanConsecutive() else {
            currentIndex = i
            return nil
        }
        return .alternative(first, second)
    }
}

fileprivate let input = Bundle.module.text(named: "day19")

public func day19_1() -> Int {
    countValidMessages(input)
}

public func day19_2() -> Int {
    countValidMessages(input, p2: true)
}
