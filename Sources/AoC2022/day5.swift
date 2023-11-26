import Foundation
import AdventCore
import Collections

//     [D]
// [N] [C]
// [Z] [M] [P]
//  1   2   3
//
// move 1 from 2 to 1
// move 3 from 1 to 3
// move 2 from 2 to 1
// move 1 from 1 to 2

struct CrateInstruction {
    var count: Int
    var from: Int
    var to: Int

    init?(_ input: String) {
        let scanner = Scanner(string: input)
        guard let _ = scanner.scanString("move"),
              let count = scanner.scanInt(),
              let _ = scanner.scanString("from"),
              let from = scanner.scanInt(),
              let _ = scanner.scanString("to"),
              let to = scanner.scanInt() else {
            return nil
        }
        self.count = count
        self.from = from - 1
        self.to = to - 1
    }
}

struct Crates {

    var stacks: [Deque<String>]

    mutating func process(instructions: [CrateInstruction], reverse: Bool) {
        for i in instructions {
            var items = stacks[i.from].prefix(i.count)
            stacks[i.from].removeFirst(i.count)
            if (reverse) {
                items.reverse()
            }
            stacks[i.to].prepend(contentsOf: items)
        }
    }

    var top: [String] {
        stacks.compactMap { $0.first }
    }

}

//"[Z] [M] [P]"

extension Crates {

    init(_ input: String) {
        let lines = input.lines().reversed()
        stacks = Array(repeating: [], count: lines.first!.split(separator: " ").count)
        for line in lines.dropFirst() {
            let lineCharacters = Array(line)
            for i in stacks.indices {
                //01234567890123
                //[Z] [M] [P]
                let c = 1 + i * 4
                if c <= lineCharacters.endIndex && lineCharacters[c] != " " {
                    stacks[i].prepend(String(lineCharacters[c]))
                }
            }
        }
    }

    static func solve(_ input: String, reverse: Bool = true) -> String {
        let sections = input.groups()
        var crates = Crates(sections[0])
        let instructions = sections[1].lines().compactMap(CrateInstruction.init)
        crates.process(instructions: instructions, reverse: reverse)
        return crates.top.joined()
    }
}


public func day5_1(_ input: String) -> String {
    Crates.solve(input)
}

public func day5_2(_ input: String) -> String {
    Crates.solve(input, reverse: false)
}
