import Foundation
import AdventCore
import SE0270_RangeSet

struct RebootStep {
    var xRange: ClosedRange<Int>
    var yRange: ClosedRange<Int>
    var zRange: ClosedRange<Int>
    var state: Bit
}

struct Geometry {

    // non intersecting - every Offset3D is within at most one cube
    var cubes = [Cube]()

    var volume: Int {
        cubes.map(\.volume).sum()
    }

    class Cube {

        init(x: ClosedRange<Int>, y: ClosedRange<Int>, z: ClosedRange<Int>) {
            self.x = x
            self.y = y
            self.z = z
        }

        // inclusive (closed) bounds
        var x: ClosedRange<Int>
        var y: ClosedRange<Int>
        var z: ClosedRange<Int>

        func range(axis: Axis3D) -> ClosedRange<Int> {
            switch axis {
            case .x: return x
            case .y: return y
            case .z: return z
            }
        }

        func intersects(_ other: Cube) -> Bool {
            x.overlaps(other.x) && y.overlaps(other.y) && z.overlaps(other.z)
        }

        func split(_ other: Cube, axis: Axis3D) -> [ClosedRange<Int>] {
            let r = range(axis: axis)
            let o = other.range(axis: axis)
            assert(r.overlaps(o))
            var result = [r]
            if o.lowerBound < r.lowerBound {
                result.append(o.lowerBound...(r.lowerBound - 1))
            }
            if o.upperBound > r.upperBound {
                result.append((r.upperBound + 1)...o.upperBound)
            }
            return result
        }

        // Returns cubes that make up other, without self
        func divide(_ other: Cube) -> [Cube] {
            let xSplits = split(other, axis: .x)
            let ySplits = split(other, axis: .y)
            let zSplits = split(other, axis: .z)
            return xSplits.flatMap { xSplit in
                ySplits.flatMap { ySplit in
                    zSplits.map { zSplit in
                        Cube(x: xSplit, y: ySplit, z: zSplit)
                    }
                }
            }
        }

        func add(_ other: Cube) -> [Cube] {
            divide(other).filter { !$0.intersects(self) }
        }

        func subtract(_ other: Cube) -> [Cube] {
            other.divide(self).filter { !$0.intersects(self) }
        }

        var volume: Int {
            x.count * y.count * z.count
        }
    }

    mutating func add(_ cube: Cube) {
        guard let existing = cubes.first(where: { $0.intersects(cube) }) else {
            cubes.append(cube)
            return
        }
        let toAdd = existing.add(cube)
        for c in toAdd {
            // ensure any other intersecting cubes are updated
            self.add(c)
        }
    }

    mutating func subtract(_ cube: Cube) {
        let r = cubes.subranges(where: { $0.intersects(cube) })
        let intersecting = Array(cubes[r])
        cubes.removeSubranges(r)
        for existing in intersecting {
            cubes.append(contentsOf: existing.subtract(cube))
        }
    }
}

extension Geometry.Cube : Equatable {
    static func == (lhs: Geometry.Cube, rhs: Geometry.Cube) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
}

public struct SubReactor {

    var cubes = Geometry()

    let limit = -50..<51

    func limit(_ range: ClosedRange<Int>) -> Range<Int> {
        (range.lowerBound..<(range.upperBound + 1)).clamped(to: limit)
    }

    mutating func boot(steps: [RebootStep]) {
        for step in steps {
            let cube = Geometry.Cube(x: step.xRange, y: step.yRange, z: step.zRange)
            if Bool(step.state) {
                cubes.add(cube)
            } else {
                cubes.subtract(cube)
            }
        }
    }

    public static func countOn(initialization: String) -> Int {
        let instructions = initialization.lines().map(RebootStep.init)
        var reactor = SubReactor()
        reactor.boot(steps: instructions)
        return reactor.cubes.volume
    }

    public static func countOn(reboot: String) -> Int {
        let instructions = reboot.lines().map(RebootStep.init)
        var reactor = SubReactor()
        reactor.boot(steps: instructions)
        return reactor.cubes.volume
    }

}

fileprivate extension Scanner {

    func scanState() -> Bit? {
        if scanString("on") != nil {
            return .on
        } else if scanString("off") != nil {
            return .off
        } else {
            return nil
        }
    }

    func scanRange(name: String) -> ClosedRange<Int>? {
        if let _ = scanString(name),
           let _ = scanString("="),
           let start = scanInt(),
           let _ = scanString(".."),
           let end = scanInt() {
            return start...end
        } else {
            return nil
        }
    }

    func scanRebootStep() -> RebootStep? {
        if let state = scanState(),
           let xRange = scanRange(name: "x"),
           let _ = scanString(","),
           let yRange = scanRange(name: "y"),
           let _ = scanString(","),
           let zRange = scanRange(name: "z") {
            return RebootStep(xRange: xRange, yRange: yRange, zRange: zRange, state: state)
        } else {
            return nil
        }
    }
}

extension RebootStep {

// on x=10..12,y=10..12,z=10..12
// on x=11..13,y=11..13,z=11..13
// off x=9..11,y=9..11,z=9..11

    init(_ description: String) {
        self = Scanner(string: description).scanRebootStep()!
    }
}



fileprivate let day22_input = Bundle.module.text(named: "day22")

public func day22_1() -> Int {
    SubReactor.countOn(initialization: day22_input)
}

public func day22_2() -> Int {
    0
}
