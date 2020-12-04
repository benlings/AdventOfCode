import Foundation

public enum PassportField : String, CaseIterable {
    case byr // (Birth Year)
    case iyr // (Issue Year)
    case eyr // (Expiration Year)
    case hgt // (Height)
    case hcl // (Hair Color)
    case ecl // (Eye Color)
    case pid // (Passport ID)
    case cid // (Country ID)
}

public typealias Passport = [PassportField : String]

public extension Scanner {
    func scanPassport() -> Passport? {
        guard let record = scanUpToString("\n\n") else { return nil }
        var passport = Passport()
        for field in record.components(separatedBy: .whitespacesAndNewlines) {
            let components = field.split(separator: ":")
            guard components.count == 2 else { break }
            passport[PassportField(rawValue: String(components[0]))!] = String(components[1])
        }
        return passport
    }
}

public func day4_1() {
    let scanner = Scanner(string: readFile("day4.txt"))
    let required = PassportField.allCases.filter { $0 != .cid }
    let count = sequence(state: scanner) { $0.scanPassport() }
        .filter { passport in
            required.allSatisfy { passport.keys.contains($0) }
        }.count
    print(count)
}
