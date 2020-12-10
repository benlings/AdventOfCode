import Foundation

public extension Sequence {
    func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        for element in self {
            if try predicate(element) {
                count += 1
            }
        }
        return count
    }

    /// Returns an array containing the results of
    ///
    ///   p.reduce(initial, nextPartialResult)
    ///
    /// for each prefix `p` of `self`, in order from shortest to
    /// longest. For example:
    ///
    ///     (1..<6).scan(0, +) // [0, 1, 3, 6, 10, 15]
    ///
    /// - Complexity: O(n)
    func scan<Result>(
        _ initial: Result,
        _ nextPartialResult: (Result, Element) -> Result
    ) -> [Result] {
        var result = [initial]
        for x in self {
            result.append(nextPartialResult(result.last!, x))
        }
        return result
    }
}

extension Sequence where Element: Equatable {
    public func count(of element: Element) -> Int {
        count(where: { $0 == element })
    }
}

public extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element {
        reduce(Element.zero, +)
    }
}

public extension Sequence where Element: Numeric {
    func product() -> Element {
        reduce(1, *)
    }
}

public extension Sequence where Element: StringProtocol {
    func ints() -> [Int] {
        compactMap { Int($0) }
    }
}
