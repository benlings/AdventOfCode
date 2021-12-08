import XCTest
import AoC2021

final class Day8Tests: XCTestCase {

    let exampleInput = """
    be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
    edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
    fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
    fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
    aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
    fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
    dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
    bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
    egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
    gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
    """.lines()

    let input = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"

    func testPart1Example() {
        XCTAssertEqual(DisplaySignals.count1478(input: exampleInput), 26)
    }

    func testPart1() {
        XCTAssertEqual(day8_1(), 390)
    }

    func testDecodeDigits() {
        let signals = DisplaySignals(input)
        let decoded = signals.decodeDigits()
        XCTAssertEqual(decoded[SignalPattern("acedgfb")], 8)
        XCTAssertEqual(decoded[SignalPattern("cdfbe")], 5)
        XCTAssertEqual(decoded[SignalPattern("gcdfa")], 2)
        XCTAssertEqual(decoded[SignalPattern("fbcad")], 3)
        XCTAssertEqual(decoded[SignalPattern("dab")], 7)
        XCTAssertEqual(decoded[SignalPattern("cefabd")], 9)
        XCTAssertEqual(decoded[SignalPattern("cdfgeb")], 6)
        XCTAssertEqual(decoded[SignalPattern("eafb")], 4)
        XCTAssertEqual(decoded[SignalPattern("cagedb")], 0)
        XCTAssertEqual(decoded[SignalPattern("ab")], 1)
    }

    func testPart2Example() {
        XCTAssertEqual(DisplaySignals.sumOutputs(input: exampleInput), 61229)
    }

    func testPart2() {
        XCTAssertEqual(day8_2(), 1011785)
    }
}
