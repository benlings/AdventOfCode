import Foundation
import AdventCore
import Algorithms

public func countAnyoneAnswers(groupAnswers: String) -> Int {
    groupAnswers.components(separatedBy: .whitespacesAndNewlines).joined().uniqued().count
}

public func countGroups(multipleGroupAnswers: String, groupCount: (String) -> Int) -> Int {
    multipleGroupAnswers.components(separatedBy: "\n\n").map(groupCount).sum()
}

fileprivate let day6_input = Bundle.module.text(named: "day6")

public func day6_1() -> Int {
    countGroups(multipleGroupAnswers: day6_input, groupCount: countAnyoneAnswers(groupAnswers:))
}

public func day6_2() -> Int {
    0
}
