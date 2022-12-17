import Foundation

public extension Scanner {
    func peekString(_ s: String) -> Bool {
        let i = currentIndex
        defer { currentIndex = i }
        return scanString(s) != nil
    }

    func scanSequence<T>(separator: String, scanElement: (Scanner) -> T?) -> [T] {
        var result = [T]()
        while let r = scanElement(self) {
            result.append(r)
            _ = scanString(separator)
        }
        return result
    }
}
