import SE0270_RangeSet

extension RangeSet where Bound: AdditiveArithmetic {
  public var count: Bound {
    ranges.lazy.map { $0.upperBound - $0.lowerBound }.sum()
  }
}

