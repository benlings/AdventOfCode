import Foundation

public struct Policy {
    public var lower: Int
    public var upper: Int
    public var limit: ClosedRange<Int> {
        lower...upper
    }
    public var character: Character

    public func conforms1(password: String) -> Bool {
        limit.contains(password.filter { $0 == character }.count)
    }

    public func conforms2(password: String) -> Bool {
        let characters = Array(password)
        let pos1 = characters[lower - 1] == character
        let pos2 = characters[upper - 1] == character
        return pos1 != pos2
    }
}

// eg. "1-3 a: abcde"
public func parseRow(_ row: String) -> (Policy, String) {
    let scanner = Scanner(string: row)
    let lower = scanner.scanInt()!
    _ = scanner.scanString("-")!
    let upper = scanner.scanInt()!
    let character = scanner.scanCharacter()!
    _ = scanner.scanString(":")!
    let password = scanner.scanUpToCharacters(from: .whitespacesAndNewlines)!
    return (Policy(lower: lower, upper: upper, character: character), password)
}

public func day2_1() {
    let count = readLines("day2.txt")
        .map(parseRow)
        .filter { (policy, password) in
            policy.conforms1(password: password)
        }
        .count
    print("\(count)")
}

public func day2_2() {
    let count = readLines("day2.txt")
        .map(parseRow)
        .filter { (policy, password) in
            policy.conforms2(password: password)
        }
        .count
    print("\(count)")
}
