import Foundation
import AdventCore

public enum Wire : Character {
    case a = "a", b = "b", c = "c", d = "d", e = "e", f = "f", g = "g"
}

public extension Set<Wire> {
    init(_ description: String) {
        self = description.compactMap(Wire.init(rawValue:)).toSet()
    }
}

public typealias SignalPattern = Set<Wire>

public struct DisplaySignals {
    var signalPatterns: [SignalPattern]
    var output: [SignalPattern]

    /*
       0:      1:      2:      3:      4:
      aaaa    ....    aaaa    aaaa    ....
     b    c  .    c  .    c  .    c  b    c
     b    c  .    c  .    c  .    c  b    c
      ....    ....    dddd    dddd    dddd
     e    f  .    f  e    .  .    f  .    f
     e    f  .    f  e    .  .    f  .    f
      gggg    ....    gggg    gggg    ....

       5:      6:      7:      8:      9:
      aaaa    aaaa    aaaa    aaaa    aaaa
     b    .  b    .  .    c  b    c  b    c
     b    .  b    .  .    c  b    c  b    c
      dddd    dddd    ....    dddd    dddd
     .    f  e    f  .    f  e    f  .    f
     .    f  e    f  .    f  e    f  .    f
      gggg    gggg    ....    gggg    gggg
     */
    public func decodeDigits() -> [SignalPattern : Int] {
        let byCount = signalPatterns.group(by: \.count)
        let one = byCount[2]!.first!
        let four = byCount[4]!.first!
        let seven = byCount[3]!.first!
        let eight = byCount[7]!.first!
        let sixSegment = byCount[6]!
        let nine = sixSegment.first { $0.intersection(four) == four }!
        let six = sixSegment.first { $0.intersection(one) != one }!
        let zero = sixSegment.first { $0 != nine && $0 != six }!
        let fiveSegment = byCount[5]!
        let three = fiveSegment.first { $0.intersection(one) == one }!
        let fmo = four.subtracting(one)
        let five = fiveSegment.first { $0.intersection(fmo) == fmo }!
        let two = fiveSegment.first { $0 != three && $0 != five }!
        return [zero: 0, one : 1, two: 2, three: 3, four : 4, five: 5, six : 6, seven : 7, eight : 8, nine : 9]
    }

    func decodeOutput(digits: [SignalPattern : Int]) -> [Int] {
        output.compactMap { digits[$0] }
    }

    public static func sumOutputs(input: [String]) -> Int {
        let signals = input.map(DisplaySignals.init)
        return signals.map { signal in
            signal.decodeOutput(digits: signal.decodeDigits()).reduce(0) { sum, digit in
                sum * 10 + digit
            }
        }.sum()
    }


    public static func count1478(input: [String]) -> Int {
        let output1478Counts: Set<Int> = [2, 4, 3, 7]
        let signals = input.map(DisplaySignals.init)
        return signals.map { signal in
            signal.output.count { output1478Counts.contains($0.count) }
        }.sum()
    }
}

extension DisplaySignals {
    public init(_ description: String) {
        let scanner = Scanner(string: description)
        let possibleWires = CharacterSet(charactersIn: "abcdefg")
        var patterns = [SignalPattern]()
        while let wires = scanner.scanCharacters(from: possibleWires) {
            patterns.append(SignalPattern(wires))
        }
        _ = scanner.scanString("|")
        var output = [SignalPattern]()
        while let wires = scanner.scanCharacters(from: possibleWires) {
            output.append(SignalPattern(wires))
        }
        self = .init(signalPatterns: patterns, output: output)
    }
}

fileprivate let day8_input = Bundle.module.text(named: "day8").lines()

public func day8_1() -> Int {
    DisplaySignals.count1478(input: day8_input)
}

public func day8_2() -> Int {
    DisplaySignals.sumOutputs(input: day8_input)
}
