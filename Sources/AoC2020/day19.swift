import Foundation
import AdventCore

public indirect enum MessageRule : Equatable {
    case character(Character)
    case consecutive([Int])
    case alternative(MessageRule, MessageRule)
}

public struct MessageRules {
    public var rules: [Int : MessageRule]

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

public func day19_1() -> Int {
    0
}

public func day19_2() -> Int {
    0
}
