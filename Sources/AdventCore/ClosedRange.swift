import Foundation

public extension ClosedRange {

    func contains(_ other: ClosedRange<Self.Bound>) -> Bool {
        lowerBound <= other.lowerBound && upperBound >= other.upperBound
    }

}
