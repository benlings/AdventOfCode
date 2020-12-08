import Foundation
import AdventCore
import Algorithms

public struct Present {
    let dimensions: [Int]

    var wrappingArea: Int {
        dimensions.permutations(ofCount: 2).map { $0.product() }.sum() + dimensions.sorted().prefix(2).product()
    }

    var ribbonLength: Int {
        2 * dimensions.sorted().prefix(2).sum() + dimensions.product()
    }
}

public extension Present {
    init?(_ description: String) {
        self = .init(dimensions: description.components(separatedBy: "x").compactMap { Int($0) })
    }
}

fileprivate let day2_input = Bundle.module.text(named: "day2").lines()

public func day2_1() -> Int {
    day2_input.compactMap(Present.init).map(\.wrappingArea).sum()
}

public func day2_2() -> Int {
    day2_input.compactMap(Present.init).map(\.ribbonLength).sum()
}
