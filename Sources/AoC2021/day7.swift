import Foundation
import AdventCore

public struct CrabSwarm {
    var positions: [Int]

    // https://www.mathsisfun.com/algebra/sequences-sums-arithmetic.html
    func sumArithmetic(_ n: Int) -> Int {
        n * (2 + (n - 1))/2
    }

    func fuelCost(_ pos: Int) -> Int {
        positions.reduce(0) { $0 + abs($1 - pos) }
    }

    func fuelCostArithmetic(_ pos: Int) -> Int {
        positions.reduce(0) { $0 + sumArithmetic(abs($1 - pos)) }
    }

    public func findMinFuelCost() -> Int {
        let (min, max) = positions.minAndMax()!
        return (min...max).map { fuelCost($0) }.min()!
    }

    public func findMinFuelCostArithmetic() -> Int {
        let (min, max) = positions.minAndMax()!
        return (min...max).map { fuelCostArithmetic($0) }.min()!
    }

}

public extension CrabSwarm {
    init(_ description: String) {
        self.positions = description.commaSeparated().ints()
    }
}

fileprivate let day7_input = Bundle.module.text(named: "day7").lines()[0]

public func day7_1() -> Int {
    CrabSwarm(day7_input).findMinFuelCost()
}

public func day7_2() -> Int {
    CrabSwarm(day7_input).findMinFuelCostArithmetic()
}
