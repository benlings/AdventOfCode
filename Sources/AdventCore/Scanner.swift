import Foundation

public extension Scanner {
    func peekString(_ s: String) -> Bool {
        let i = currentIndex
        defer { currentIndex = i }
        return scanString(s) != nil
    }

    /// Reset index if optional is nil
    func scanOptional<T>(scanItem: () -> T?) -> T? {
        let i = currentIndex
        guard let item = scanItem() else {
            currentIndex = i
            return nil
        }
        return item
    }

    func scanSequence<T>(separator: String, scanElement: () -> T?) -> [T] {
        var result = [T]()
        while let r = scanOptional(scanItem: scanElement) {
            result.append(r)
            _ = scanString(separator)
        }
        return result
    }
}
