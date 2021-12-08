import Foundation
import AdventCore

enum Wire : Character {
    case a = "a", b = "b", c = "c", d = "d", e = "e", f = "f", g = "g"
}

public struct DisplaySignals {
    var signalPatterns: Set<[Wire]>
    var output: [Set<Wire>]

    public static func count1478(input: [String]) -> Int {
        let output1478Counts: Set<Int> = [2, 4, 3, 7]
        let signals = input.map(DisplaySignals.init)
        return signals.map { signal in
            signal.output.count { output1478Counts.contains($0.count) }
        }.sum()
    }
}

extension DisplaySignals {
    init(_ description: String) {
        let scanner = Scanner(string: description)
        let possibleWires = CharacterSet(charactersIn: "abcdefg")
        var patterns = Set<[Wire]>()
        while let wires = scanner.scanCharacters(from: possibleWires) {
            patterns.update(with: wires.compactMap(Wire.init(rawValue:)))
        }
        _ = scanner.scanString("|")
        var output = [Set<Wire>]()
        while let wires = scanner.scanCharacters(from: possibleWires) {
            output.append(wires.compactMap(Wire.init(rawValue:)).toSet())
        }
        self = .init(signalPatterns: patterns, output: output)
    }
}

fileprivate let day8_input = Bundle.module.text(named: "day8").lines()

public func day8_1() -> Int {
    DisplaySignals.count1478(input: day8_input)
}

public func day8_2() -> Int {
    0
}
