import Foundation

public struct Policy {
    public var limit: ClosedRange<Int>
    public var character: Character

    public func conforms(password: String) -> Bool {
        limit.contains(password.filter { $0 == character }.count)
    }
}


public func parseRow(_ row: String) -> (Policy, String) {
    let scanner = Scanner(string: row)
    let lower = scanner.scanInt()!
    _ = scanner.scanString("-")!
    let upper = scanner.scanInt()!
    let character = scanner.scanCharacter()!
    _ = scanner.scanString(":")!
    let password = scanner.scanUpToCharacters(from: .whitespacesAndNewlines)!
    return (Policy(limit: lower...upper, character: character), password)
}

public func day2_1() {
    let count = readLines("day2.txt")
        .map(parseRow)
        .filter { (policy, password) in
            policy.conforms(password: password)
        }
        .count
    print("\(count)")
}
