import Foundation
import AdventCore

public struct CrabSwarm {
    var positions: [Int]

    func fuelCost(_ pos: Int, _ cost: (Int) -> Int) -> Int {
        positions.map { cost(abs($0 - pos)) }.sum()
    }

    public func findMinFuelCost(_ cost: (Int) -> Int) -> Int {
        positions.range()!.map { fuelCost($0, cost) }.min()!
    }

    public func findMinFuelCostLinear() -> Int {
        func linearCost(_ n: Int) -> Int {
            n
        }
        return findMinFuelCost(linearCost)
    }

    public func findMinFuelCostArithmetic() -> Int {
        // https://www.mathsisfun.com/algebra/sequences-sums-arithmetic.html
        func arithmeticCost(_ n: Int) -> Int {
            n * (2 + (n - 1))/2
        }
        return findMinFuelCost(arithmeticCost)
    }

}

public extension CrabSwarm {
    init(_ description: String) {
        self.positions = description.commaSeparated().ints()
    }
}

fileprivate let day7_input = Bundle.module.text(named: "day7").lines()[0]

public func day7_1() -> Int {
    CrabSwarm(day7_input).findMinFuelCostLinear()
}

public func day7_2() -> Int {
    CrabSwarm(day7_input).findMinFuelCostArithmetic()
}
