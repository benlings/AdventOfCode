import Foundation

func readLines(_ resourceName: String) -> [String] {
    let url = Bundle.main.url(forResource: resourceName, withExtension: nil)!
    let text = try! String(contentsOf: url)
    let lines = text.split(whereSeparator: \.isNewline)
    return lines.map(String.init)
}

public func day1_1() {
    let numbers = readLines("day1.txt").compactMap { Int($0) }.lazy
    let match = numbers.flatMap { n1 in
        numbers.map { n2 in (n1, n2) }
    }.first { (n1, n2) in n1 + n2 == 2020 }!
    print("\(match): \(match.0 * match.1)")
}

public func day1_2() {
    let numbers = readLines("day1.txt").compactMap { Int($0) }.lazy
    let match2 = numbers.flatMap { n1 in
        numbers.flatMap { n2 in
            numbers.map { n3 in (n1, n2, n3) }
        }
    }.first { (nums: (Int, Int, Int)) -> Bool in nums.0 + nums.1 + nums.2 == 2020 }!

    print("\(match2): \(match2.0 * match2.1 * match2.2)")
}
