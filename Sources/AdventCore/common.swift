import Foundation

public extension Bundle {
    func text(named: String, extension: String = "txt") -> String {
        let url = self.url(forResource: named, withExtension: `extension`)!
        return try! String(contentsOf: url)
    }
}

public extension String {
    func lines() -> [String] {
        let lines = self.split(whereSeparator: \.isNewline)
        return lines.map(String.init)
    }
}
