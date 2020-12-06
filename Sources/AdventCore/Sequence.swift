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
