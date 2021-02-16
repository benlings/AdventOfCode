import Foundation

public extension String {
    func lines() -> [String] {
        let lines = self.split(whereSeparator: \.isNewline)
        return lines.map(String.init)
    }

    func commaSeparated() -> [String] {
        self.components(separatedBy: ",")
    }

    func groups() -> [String] {
        self
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: "\n\n")
    }

    func count(of other: String) -> Int {
        self.components(separatedBy: other).count - 1
    }
}
