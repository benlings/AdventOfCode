import Foundation

public extension Collection {
    func reduce(_ nextPartialResult: (Element, Element) throws -> Element) rethrows -> Element? {
        guard let first = first else {
            return nil
        }
        return try dropFirst().reduce(first, nextPartialResult)
    }

    @inlinable func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence, on selector: (Element) -> some Comparable) -> Bool where OtherSequence : Sequence, Self.Element == OtherSequence.Element {
        lexicographicallyPrecedes(other) {
            selector($0) < selector($1)
        }
    }

}

public extension Collection where Element: Comparable {
    func median() -> Element? {
        count % 2 == 1 ? sorted()[count / 2] : nil
    }
}

extension Collection where Element: Collection {

    public typealias InnerElement = Element.Element

    public func column(_ index: Element.Index) -> [InnerElement] {
        self.map { $0[index] }
    }

    public func columns() -> [[InnerElement]] {
        columnIndices.map { column($0) }
    }

    public var columnIndices: Element.Indices {
        self.first!.indices
    }

}
