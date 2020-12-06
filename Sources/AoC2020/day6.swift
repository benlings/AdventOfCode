import Foundation
import AdventCore
import Algorithms

public func count(groupAnswers: String) -> Int {
    groupAnswers.components(separatedBy: .whitespacesAndNewlines).joined().uniqued().count
}

public func count(multipleGroupAnswers: String) -> Int {
    multipleGroupAnswers.components(separatedBy: "\n\n").map(count(groupAnswers:)).sum()
}

fileprivate let day6_input = Bundle.module.text(named: "day6")

public func day6_1() -> Int {
    count(multipleGroupAnswers: day6_input)
}

public func day6_2() -> Int {
    0
}
