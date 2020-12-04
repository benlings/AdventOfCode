import Foundation

public func readLines(_ resourceName: String) -> [String] {
    return readFile(resourceName).lines()
}

public func readFile(_ resourceName: String) -> String {
    let url = Bundle.main.url(forResource: resourceName, withExtension: nil)!
    return try! String(contentsOf: url)
}

public extension String {
    func lines() -> [String] {
        let lines = self.split(whereSeparator: \.isNewline)
        return lines.map(String.init)
    }
}
