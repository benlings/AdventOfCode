import Foundation

public struct Regex<T> {

    private let expression: NSRegularExpression

    public func findMatch(_ string: String) -> Match? {
        let range = NSRange(location: 0, length: string.utf16.count)
        guard
            let result = expression.firstMatch(in: string, options: [], range: range)
        else {
            return nil
        }
        return Match(string: string, result: result)
    }

    public func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return expression.firstMatch(in: string, options: [], range: range) != nil
    }

    public func matches(in string: String) -> [Match] {
        let range = NSRange(location: 0, length: string.utf16.count)
        return expression
            .matches(in: string, options: [], range: range)
            .map { Match(string: string, result: $0) }
    }
}

extension Regex {
    public init(_ pattern: StaticString, options: NSRegularExpression.Options = []) where T == Never {
        expression = try! NSRegularExpression(pattern: pattern.description, options: options)
        precondition(expression.numberOfCaptureGroups == 0)
    }

    public func match(_ string: String) -> Substring?  where T == Never {
        let match = findMatch(string)
        return match.map { string[$0.range] }
    }

    public init(_ pattern: StaticString, options: NSRegularExpression.Options = []) where T : LosslessStringConvertible {
        expression = try! NSRegularExpression(pattern: pattern.description, options: options)
        precondition(expression.numberOfCaptureGroups == 1)
    }

    public func match(_ string: String) -> T?  where T : LosslessStringConvertible {
        let match = findMatch(string)
        return match.flatMap { T(String(string[$0.captureGroups[0].range])) }
    }

    public init<T1, T2>(_ pattern: StaticString, options: NSRegularExpression.Options = []) where T == (T1, T2), T1 : LosslessStringConvertible, T2 : LosslessStringConvertible {
        expression = try! NSRegularExpression(pattern: pattern.description, options: options)
        precondition(expression.numberOfCaptureGroups == 2)
    }

    public func match<T1, T2>(_ string: String) -> T?  where T == (T1, T2), T1 : LosslessStringConvertible, T2 : LosslessStringConvertible {
        guard let match = findMatch(string),
              let r1 = T1(String(string[match.captureGroups[0].range])),
              let r2 = T2(String(string[match.captureGroups[1].range]))
        else {
            return nil
        }
        return (r1, r2)
    }

}

// MARK: - Capture Group

extension Regex {

    public struct CaptureGroup {
        public let string: String
        public let range: Range<String.Index>
    }
}

extension Regex.CaptureGroup: CustomStringConvertible {
    public var description: String { String(string[range]) }
}

// MARK: - Match

extension Regex {

    public struct Match {
        public let string: String
        public let range: Range<String.Index>
        public let captureGroups: [CaptureGroup]
    }
}

extension Regex.Match {

    fileprivate init(string: String, result: NSTextCheckingResult) {
        self.string = string
        range = Range(result.range, in: string)!
        captureGroups = (1..<result.numberOfRanges)
            .map { result.range(at: $0) }
            .map { Range($0, in: string)! }
            .map { Regex.CaptureGroup(string: string, range: $0) }
    }
}

extension Regex.Match where T : LosslessStringConvertible {



}

extension Regex.Match {

    public func string(at index: Int) -> String {
        precondition(index >= 0 && index < captureGroups.count)
        return captureGroups[index].description
    }

    public func integer(at index: Int) -> Int? {
        Int(string(at: index))
    }

    public func character(at index: Int) -> Character? {
        Character(string(at: index))
    }
}
