import Foundation

public extension Collection {
    func reduce(_ nextPartialResult: (Element, Element) throws -> Element) rethrows -> Element? {
        guard let first = first else {
            return nil
        }
        return try reduce(first, nextPartialResult)
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

    public var columnCount: Int {
        self.first!.count
    }

}
