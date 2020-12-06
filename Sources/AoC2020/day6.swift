import Foundation
import AdventCore
import Algorithms

public func countAnyoneAnswers(groupAnswers: String) -> Int {
    groupAnswers.components(separatedBy: .whitespacesAndNewlines).joined().uniqued().count
}

public func countEveryoneAnswers(groupAnswers: String) -> Int {
    groupAnswers.components(separatedBy: .whitespacesAndNewlines)
        .map { Set($0) }
        .reduce { $0.intersection($1) }!
        .count
}

public func countGroups(multipleGroupAnswers: String, groupCount: (String) -> Int) -> Int {
    multipleGroupAnswers.groups().map(groupCount).sum()
}

fileprivate let day6_input = Bundle.module.text(named: "day6")

public func day6_1() -> Int {
    countGroups(multipleGroupAnswers: day6_input, groupCount: countAnyoneAnswers(groupAnswers:))
}

public func day6_2() -> Int {
    countGroups(multipleGroupAnswers: day6_input, groupCount: countEveryoneAnswers(groupAnswers:))
}
