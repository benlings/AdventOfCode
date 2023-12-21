import OrderedCollections

extension Hashable {
  public func extrapolate(count: Int, operation: (inout Self) -> ()) -> Self {
    var current = self
    var previous = OrderedSet<Self>()
    var count = count
    repeat {
      operation(&current)
      count -= 1
      let (inserted, index) = previous.append(current)
      guard inserted else {
        let period = previous.count - index
        let offset = count % period
        current = previous[offset + index]
        break
      }
    } while count > 0
    return current
  }
}
