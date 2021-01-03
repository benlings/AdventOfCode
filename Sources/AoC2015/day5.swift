import Foundation
import AdventCore

/**
 A nice string is one with all of the following properties:

 * It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
 * It contains at least one letter that appears twice in a row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
 * It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.
 */

public func isNicePart1(_ string: String) -> Bool {
    let vowels = CharacterSet(charactersIn: "aeiou")
    let contains3Vowels = string.unicodeScalars.count(where: vowels.contains) >= 3
    let containsRepeatedLetter = string.range(of: "([a-z])(\\1)", options: .regularExpression) != nil
    let containsMagicString = string.range(of: "(ab|cd|pq|xy)", options: .regularExpression) != nil
    return contains3Vowels && containsRepeatedLetter && !containsMagicString
}

/**
 a nice string is one with all of the following properties:

 * It contains a pair of any two letters that appears at least twice in the string without overlapping, like xyxy (xy) or aabcdefgaa (aa), but not like aaa (aa, but it overlaps).
 * It contains at least one letter which repeats with exactly one letter between them, like xyx, abcdefeghi (efe), or even aaa.
 */
public func isNicePart2(_ string: String) -> Bool {
    let containsPairTwice = string.range(of: "([a-z]{2}).*(\\1)", options: .regularExpression) != nil
    let containsRepeatedLetterWithLetterBetween = string.range(of: "([a-z])[a-z](\\1)", options: .regularExpression) != nil
    return containsPairTwice && containsRepeatedLetterWithLetterBetween
}

private let input = Bundle.module.text(named: "day5")

public func day5_1() -> Int {
    input.lines().count(where: isNicePart1)
}

public func day5_2() -> Int {
    input.lines().count(where: isNicePart2)
}
