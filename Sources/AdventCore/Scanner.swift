import Foundation

public extension Scanner {
    func peekString(_ s: String) -> Bool {
        let i = currentIndex
        defer { currentIndex = i }
        return scanString(s) != nil
    }
}
