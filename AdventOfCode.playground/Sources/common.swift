import Foundation

public func readLines(_ resourceName: String) -> [String] {
    let url = Bundle.main.url(forResource: resourceName, withExtension: nil)!
    let text = try! String(contentsOf: url)
    return text.lines()
}

public extension String {
    func lines() -> [String] {
        let lines = self.split(whereSeparator: \.isNewline)
        return lines.map(String.init)
    }
}
