import XCTest
import AoC2020

final class Day19Tests: XCTestCase {

    func testPart1Example1() {
        let input = """
        0: 1 2
        1: "a"
        2: 1 3 | 3 1
        3: "b"
        """
        let rules = MessageRules(input)
        XCTAssertEqual(rules.rules, [
            0: .consecutive([1, 2]),
            1: .character("a"),
            2: .alternative(.consecutive([1, 3]), .consecutive([3, 1])),
            3: .character("b"),
        ])
        XCTAssertEqual(rules.match("aab"), true)
        XCTAssertEqual(rules.match("aba"), true)
        XCTAssertEqual(rules.match("baa"), false)
        XCTAssertEqual(rules.match("aaba"), false)
    }

    func testPart1Example2() {
        let input = """
        0: 4 1 5
        1: 2 3 | 3 2
        2: 4 4 | 5 5
        3: 4 5 | 5 4
        4: "a"
        5: "b"
        """
        let rules = MessageRules(input)
        XCTAssertEqual(rules.match("aaaabb"), true)
        XCTAssertEqual(rules.match("aaabab"), true)
        XCTAssertEqual(rules.match("abbabb"), true)
        XCTAssertEqual(rules.match("abbbab"), true)
        XCTAssertEqual(rules.match("aabaab"), true)
        XCTAssertEqual(rules.match("aabbbb"), true)
        XCTAssertEqual(rules.match("abaaab"), true)
        XCTAssertEqual(rules.match("ababbb"), true)
        XCTAssertEqual(rules.match("ababba"), false)
        XCTAssertEqual(rules.match("bbabba"), false)
        XCTAssertEqual(rules.match("aaabbb"), false)
    }

    func testPart1Example3() {
        let input = """
        0: 4 1 5
        1: 2 3 | 3 2
        2: 4 4 | 5 5
        3: 4 5 | 5 4
        4: "a"
        5: "b"

        ababbb
        bababa
        abbbab
        aaabbb
        aaaabbb
        """
        XCTAssertEqual(countValidMessages(input), 2)
    }

    func testPart1() {
        XCTAssertEqual(day19_1(), 120)
    }

    func testPart2Example() {
        let input = """
        42: 9 14 | 10 1
        9: 14 27 | 1 26
        10: 23 14 | 28 1
        1: "a"
        11: 42 31
        5: 1 14 | 15 1
        19: 14 1 | 14 14
        12: 24 14 | 19 1
        16: 15 1 | 14 14
        31: 14 17 | 1 13
        6: 14 14 | 1 14
        2: 1 24 | 14 4
        0: 8 11
        13: 14 3 | 1 12
        15: 1 | 14
        17: 14 2 | 1 7
        23: 25 1 | 22 14
        28: 16 1
        4: 1 1
        20: 14 14 | 1 15
        3: 5 14 | 16 1
        27: 1 6 | 14 18
        14: "b"
        21: 14 1 | 1 14
        25: 1 1 | 1 14
        22: 14 14
        8: 42
        26: 14 22 | 1 20
        18: 15 15
        7: 14 5 | 1 21
        24: 14 1
        """
        let rules = MessageRules(input)
        XCTAssertEqual(rules.match2("abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa"), false)
        XCTAssertEqual(rules.match2("bbabbbbaabaabba"), true)
        XCTAssertEqual(rules.match2("babbbbaabbbbbabbbbbbaabaaabaaa"), true)
        XCTAssertEqual(rules.match2("aaabbbbbbaaaabaababaabababbabaaabbababababaaa"), true)
        XCTAssertEqual(rules.match2("bbbbbbbaaaabbbbaaabbabaaa"), true)
        XCTAssertEqual(rules.match2("bbbababbbbaaaaaaaabbababaaababaabab"), true)
        XCTAssertEqual(rules.match2("ababaaaaaabaaab"), true)
        XCTAssertEqual(rules.match2("ababaaaaabbbaba"), true)
        XCTAssertEqual(rules.match2("baabbaaaabbaaaababbaababb"), true)
        XCTAssertEqual(rules.match2("abbbbabbbbaaaababbbbbbaaaababb"), true)
        XCTAssertEqual(rules.match2("aaaaabbaabaaaaababaa"), true)
        XCTAssertEqual(rules.match2("aaaabbaaaabbaaa"), false)
        XCTAssertEqual(rules.match2("aaaabbaabbaaaaaaabbbabbbaaabbaabaaa"), true)
        XCTAssertEqual(rules.match2("babaaabbbaaabaababbaabababaaab"), false)
        XCTAssertEqual(rules.match2("aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba"), true)
    }

    func testPart2() {
        XCTAssertEqual(day19_2(), 350)
    }
}
