import Foundation
import AdventCore

fileprivate extension String {
    func valid(years: ClosedRange<Int>) -> Bool {
        guard self.count == 4,
              let number = Int(self) else {
            return false
        }
        return years.contains(number)
    }

    func validHeight() -> Bool {
        let s = Scanner(string: self)
        guard let height = s.scanInt() else {
            return false
        }
        if s.scanString("in") != nil {
            return (59...76).contains(height)
        } else if s.scanString("cm") != nil {
            return (150...193).contains(height)
        } else {
            return false
        }
    }

    func validColor() -> Bool {
        let s = Scanner(string: self)
        var hexDigits = CharacterSet.decimalDigits
        hexDigits.insert(charactersIn: "abcdef")
        guard let _ = s.scanString("#"),
              let digits = s.scanCharacters(from: hexDigits) else {
            return false
        }
        return digits.count == 6
    }
}

/*
 byr (Birth Year) - four digits; at least 1920 and at most 2002.
 iyr (Issue Year) - four digits; at least 2010 and at most 2020.
 eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
 hgt (Height) - a number followed by either cm or in:
 If cm, the number must be at least 150 and at most 193.
 If in, the number must be at least 59 and at most 76.
 hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
 ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
 pid (Passport ID) - a nine-digit number, including leading zeroes.
 cid (Country ID) - ignored, missing or not.
 */

public enum PassportField : String, CaseIterable {
    case byr // (Birth Year)
    case iyr // (Issue Year)
    case eyr // (Expiration Year)
    case hgt // (Height)
    case hcl // (Hair Color)
    case ecl // (Eye Color)
    case pid // (Passport ID)
    case cid // (Country ID)

    func isValid(value: String?) -> Bool {
        switch self {
        case .byr:
            return value.map { $0.valid(years: 1922...2002) } ?? false
        case .iyr:
            return value.map { $0.valid(years: 1910...2020) } ?? false
        case .eyr:
            return value.map { $0.valid(years: 1920...2030) } ?? false
        case .hgt:
            return value.map { $0.validHeight() } ?? false
        case .hcl:
            return value.map { $0.validColor() } ?? false
        case .ecl:
            return value.map { ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains($0) } ?? false
        case .pid:
            return value.map { $0.count == 9 && $0.allSatisfy { c in c.isWholeNumber && c.isASCII } } ?? false
        case .cid:
            return true
        }
    }
}

public typealias Passport = [PassportField : String]

func parsePassport(_ record: String) -> Passport {
    var passport = Passport()
    for field in record.components(separatedBy: .whitespacesAndNewlines) {
        let components = field.split(separator: ":")
        passport[PassportField(rawValue: String(components[0]))!] = String(components[1])
    }
    return passport
}

fileprivate let day4_input = Bundle.module.text(named: "day4").groups()

public func day4_1() -> Int {
    let required = PassportField.allCases.filter { $0 != .cid }
    return day4_input
        .map(parsePassport)
        .count { passport in
            required.allSatisfy { passport.keys.contains($0) }
        }
}

public func day4_2() -> Int {
    return day4_input
        .map(parsePassport)
        .count { passport in
            PassportField.allCases.allSatisfy { $0.isValid(value: passport[$0]) }
        }
}
