import Foundation

public extension String {
    func lines() -> [String] {
        let lines = self.split(whereSeparator: \.isNewline)
        return lines.map(String.init)
    }
}
