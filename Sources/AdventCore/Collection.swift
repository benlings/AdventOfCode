import Foundation

public extension Collection {
    func reduce(_ nextPartialResult: (Element, Element) throws -> Element) rethrows -> Element? {
        guard let first = first else {
            return nil
        }
        return try reduce(first, nextPartialResult)
    }

}
