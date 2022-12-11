import Foundation
import AdventCore
import Collections

/*
 Monkey 0:
   Starting items: 79, 98
   Operation: new = old * 19
   Test: divisible by 23
     If true: throw to monkey 2
     If false: throw to monkey 3
 */

class Item {
    init(worryLevel: Int) {
        self.worryLevel = worryLevel
    }

    var worryLevel: Int
}

public struct Monkey {
    let num: Int
    var items: Deque<Item>
    let operation: (Int) -> Int
    let test: (Int) -> Bool
    let destination: (true: Int, false: Int)

    mutating func takeTurn() -> [(destination: Int, item: Item)] {
        var result = [(Int, Item)]()
        while let item = items.popFirst() {
            item.worryLevel = operation(item.worryLevel) / 3
            let testResult = test(item.worryLevel)
            result.append((destination: testResult ? destination.true : destination.false, item: item))
        }
        return result
    }

    public static func monkeyBusiness(_ input: String) -> Int {
        var monkeys = input.groups().compactMap(Monkey.init)
        var inspectionCounts = Array(repeating: 0, count: monkeys.count)
        for _ in 0..<20 {
            for i in monkeys.indices {
                let thrownItems = monkeys[i].takeTurn()
                inspectionCounts[i] += thrownItems.count
                for (dest, item) in thrownItems {
                    monkeys[dest].items.append(item)
                }
            }
        }
        return inspectionCounts.max(count: 2).product()
    }
}

extension Monkey {
    init?(_ input: String) {
        let s = Scanner(string: input)
        guard let _ = s.scanString("Monkey"),
              let n = s.scanInt(),
              let _ = s.scanString(":"),
              let _ = s.scanString("Starting items: ")
        else { return nil }
        num = n
        items = Deque()
        while let level = s.scanInt() {
            items.append(Item(worryLevel: level))
            _ = s.scanString(",")
        }
        guard let _ = s.scanString("Operation: new = old"),
              let op = s.scanUpToCharacters(from: .whitespaces),
              let operand = s.scanUpToCharacters(from: .whitespacesAndNewlines),
              let _ = s.scanString("Test: divisible by"),
              let testDivisor = s.scanInt(),
              let _ = s.scanString("If true: throw to monkey"),
              let trueDestination = s.scanInt(),
              let _ = s.scanString("If false: throw to monkey"),
              let falseDestination = s.scanInt()
        else { return nil }
        if operand == "old" {
            switch op {
            case "+": operation = { $0 + $0 }
            case "*": operation = { $0 * $0 }
            default: return nil
            }
        } else {
            let operandInt = Int(operand)!
            switch op {
            case "+": operation = { $0 + operandInt }
            case "*": operation = { $0 * operandInt }
            default: return nil
            }
        }
        test = { $0 % testDivisor == 0 }
        destination = (true: trueDestination, false: falseDestination)
    }
}


fileprivate let day11_input = Bundle.module.text(named: "day11")

public func day11_1() -> Int {
    Monkey.monkeyBusiness(day11_input)
}

public func day11_2() -> Int {
    0
}
