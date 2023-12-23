import Foundation

public struct Offset3D : Hashable {

    var x, y, z: Int

    public init(x: Int = 0, y: Int = 0, z: Int = 0) {
        self.x = x
        self.y = y
        self.z = z
    }

}

extension Offset3D : AdditiveArithmetic {
    public static func - (lhs: Offset3D, rhs: Offset3D) -> Offset3D {
        Offset3D(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }

    public static func + (lhs: Offset3D, rhs: Offset3D) -> Offset3D {
        Offset3D(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }

    public static var zero: Offset3D {
        Offset3D()
    }
}

extension Offset3D {
    public static func * (lhs: Int, rhs: Self) -> Self {
      Self(x: lhs * rhs.x, y: lhs * rhs.y, z: lhs * rhs.z)
    }

    public static func / (lhs: Self, rhs: Int) -> Self {
      Self(x: lhs.x / rhs, y: lhs.y / rhs, z: lhs.z / rhs)
    }
}

public enum Axis3D {
    case x, y, z
}

extension Offset3D {
    public subscript(axis axis: Axis3D) -> Int {
      get {
        switch axis {
        case .x: return x
        case .y: return y
        case .z: return z
        }
      }
      set {
        switch axis {
        case .x: x = newValue
        case .y: y = newValue
        case .z: z = newValue
        }
      }
    }

    public func manhattanDistance(to other: Offset3D) -> Int {
        let difference = other - self
        return abs(difference.x) + abs(difference.y) + abs(difference.z)
    }

}

public extension Offset3D {

    func rotated(angle: Int, axis: Axis3D) -> Offset3D {
        let radians = Double.pi * Double(angle)/180.0
        let s = Int(sin(radians))
        let c = Int(cos(radians))
        switch axis {
        case .x:
            return Offset3D(x: x,
                            y: y * c - z * s,
                            z: y * s + z * c)
        case .y:
            return Offset3D(x: z * s + x * c,
                            y: y,
                            z: z * c - x * s)
        case .z:
            return Offset3D(x: x * c - y * s,
                            y: x * s + y * c,
                            z: z)
        }
    }

    func allOrientations(axis: Axis3D) -> [Offset3D] {
        return [
            rotated(angle: 0, axis: axis),
            rotated(angle: 90, axis: axis),
            rotated(angle: 180, axis: axis),
            rotated(angle: 270, axis: axis),
        ]
    }

    func orientations() -> [Offset3D] {
        return [
            // Orientations around x
            (self, .x), (self.rotated(angle: 180, axis: .y), .x),
            // First move x axis to the y axis, then orientations around y
            (self.rotated(angle: 90, axis: .z), .y), (self.rotated(angle: -90, axis: .z), .y),
            // First move x axis to the z axis, then orientations around z
            (self.rotated(angle: 90, axis: .y), .z), (self.rotated(angle: -90, axis: .y), .z),
        ].flatMap { $0.allOrientations(axis: $1) }
    }

}

public extension Set<Offset3D> {
    func projection(axis: Axis3D) -> (Int, IndexSet) {
        let p = map { $0[axis: axis] }
        // Ensure IndexSet starts from 0
        guard let min = p.min() else { return (0, IndexSet()) }
        return (min, p.map { $0 - min }.toIndexSet())
    }
}

extension Scanner {

  public func scanOffset3D() -> Offset3D? {
    if let x = scanInt(),
       let _ = scanString(","),
       let y = scanInt(),
       let _ = scanString(","),
       let z = scanInt() {
      return Offset3D(x: x, y: y, z: z)
    } else { return nil }
  }
}
