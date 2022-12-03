import Foundation
import AdventCore

public struct Rucksack {

    public struct Item : Hashable {
        var character: String.UTF8View.Element

        var priority: Int {
            switch character {
            case 97...122: return Int(character - 96) // a-z = 1-26
            case 65...90: return Int(character - 64 + 26) // A-Z = 27-52
            default: fatalError()
            }
        }
    }

    var compartments: (Set<Item>, Set<Item>)

    func errorItems() -> Set<Item> {
        compartments.0.intersection(compartments.1)
    }
}

public extension Rucksack {

    init(_ line: String) {
        let items = Array(line.utf8.map(Item.init(character:)))
        compartments = (Set(items[0..<items.count/2]), Set(items[items.count/2..<items.count]))
    }

    static func sumErrorPriorities(_ lines: [String]) -> Int {
        lines.map { line in
            let r = Rucksack(line)
            return r.errorItems().map(\.priority).sum()
        }.sum()
    }

}

fileprivate let day3_input = Bundle.module.text(named: "day3").lines()

public func day3_1() -> Int {
    Rucksack.sumErrorPriorities(day3_input)
}

public func day3_2() -> Int {
    0
}
