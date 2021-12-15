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

    func group<K>(by keyForValue: (Element) throws -> K) rethrows -> Dictionary<K, [Element]> {
        try Dictionary(grouping: self, by: keyForValue)
    }
}

extension Sequence where Element: Equatable {
    public func count(of element: Element) -> Int {
        count(where: { $0 == element })
    }
}

public extension Sequence where Element: Comparable {
    func range() -> ClosedRange<Element>? {
        guard let (min, max) = self.minAndMax() else { return nil }
        return (min...max)
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

public extension Sequence where Element == UInt8 {
    var hex: String {
        return self.reduce("") { string, byte in
            string + String(format: "%02x", byte)
        }
    }
}

public extension Sequence {
    func toDictionary<K, V>() -> Dictionary<K, V> where Element == (K, V) {
        Dictionary(uniqueKeysWithValues: self)
    }

    func toDictionarySummingValues<K, V>() -> Dictionary<K, V> where Element == (K, V), V : Numeric {
        Dictionary(self, uniquingKeysWith: +)
    }

    func toSet<E>() -> Set<E> where Element == E {
        Set(self)
    }

    func unionAll<E>() -> Set<E> where Element == Set<E> {
        reduce(Set()) { $0.union($1) }
    }

    func unionAll() -> IndexSet where Element == IndexSet {
        reduce(IndexSet()) { $0.union($1) }
    }

    func toArray() -> [Element] {
        Array(self)
    }

    func sorted<T>(on selector: (Element) -> T) -> [Element] where T : Comparable {
        sorted {
            selector($0) < selector($1)
        }
    }

    func min<T>(on selector: (Element) -> T) -> Element? where T : Comparable {
        self.min { selector($0) < selector($1) }
    }
}

public extension Sequence where Element == Int {
    func toIndexSet() -> IndexSet {
        self.reduce(IndexSet()) {
            $0.union(IndexSet(integer: $1))
        }
    }
}

public extension Sequence where Element: Sequence {
    func flatten() -> [Element.Element] {
        flatMap { $0 }
    }
}

public extension Sequence where Element: StringProtocol {
    func ints<T>() -> [T] where T : FixedWidthInteger {
        compactMap { T($0) }
    }
}
