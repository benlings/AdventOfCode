import Foundation

public struct Line3D: Hashable {

  public init(start: Offset3D, end: Offset3D) {
    self.start = start
    self.direction = end - start
  }

  var start: Offset3D
  var end: Offset3D {
    start + direction
  }
  var direction: Offset3D

  var length: Int {
    switch orientation {
    case .x: abs(direction.x)
    case .y: abs(direction.y)
    case .z: abs(direction.z)
    }
  }

  public mutating func move(axis: Axis3D, distance: Int) {
    self.start[axis: axis] += distance
  }

  public func min(axis: Axis3D) -> Int {
    Swift.min(start[axis: axis], end[axis: axis])
  }

  var unitDirection: Offset3D {
    direction / length
  }

  public var orientation: Axis3D {
    let difference = direction
    switch (difference.x, difference.y, difference.z) {
    case (_, 0, 0): return .x
    case (0, _, 0): return .y
    case (0, 0, _): return .z
    default: fatalError("Unsupported orientation")
    }
  }

  public var points: [Offset3D] {
    guard direction != .zero else { return [start] }
    var point = start
    let offset = unitDirection
    let iterator: AnyIterator<Offset3D> = AnyIterator {
      defer { point += offset }
      return point == end ? nil : point
    }
    return Array(iterator) + [end]
  }
}

public extension Line3D {
  init?(_ description: String) {
    let scanner = Scanner(string: description)
    guard let line = scanner.scanLine3D() else {
      return nil
    }
    self = line
  }
}

public extension Scanner {

  func scanLine3D() -> Line3D? {
    guard let start = scanOffset3D(),
          let _ = scanString("~"),
          let end = scanOffset3D() else {
      return nil
    }
    return Line3D(start: start, end: end)
  }
}
