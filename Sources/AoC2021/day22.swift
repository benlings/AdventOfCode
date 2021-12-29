import Foundation
import AdventCore
import SE0270_RangeSet

struct RebootStep {
    var cube: Geometry.Cube
    var state: Bit

    var volume: Int {
        cube.volume * (Bool(state) ? 1 : -1)
    }
}

struct Geometry {

    var cubes = [RebootStep]()

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

        func intersects(_ other: Cube) -> Bool {
            x.overlaps(other.x) && y.overlaps(other.y) && z.overlaps(other.z)
        }

        func intersection(_ other: Cube) -> Cube? {
            if intersects(other) {
                return Cube(x: x.clamped(to: other.x),
                            y: y.clamped(to: other.y),
                            z: z.clamped(to: other.z))
            } else {
                return nil
            }
        }

        func limit(_ region: Cube?) -> Cube? {
            if let region = region {
                return intersection(region)
            } else {
                return self
            }
        }

        var volume: Int {
            x.count * y.count * z.count
        }
    }

/*
 Adding: 1 + 2
 ======
 1 & 2 overlap - add 2 + RebootStep(cube: V, state: .off) = 1 + 2 - (1 ∩ 2)
 +---------+
 | 1   +---+--+
 |     | V | 2|
 +-----+---+  |
       +------+
 Adding to -ve cubes:

 1 + 2 - (1 ∩ 2)
 + 3 - (1 ∩ 3) - (2 ∩ 3) + ((1 ∩ 2) ∩ 2)

 Subtracting: 1 - 2
 ===========
 - Add RebootStep(cube: V, state: .off) = 1 - (1 ∩ 2)
 +---------+
 | 1   +---+--+
 |     | V | 2|
 +-----+---+  |
       +------+

 Subtracting from -ve cubes:

 1 - (1 ∩ 2)
 - (1 ∩ 3) + ((1 ∩ 2) ∩ 2)

 */


    fileprivate func intersctions(_ cube: Geometry.Cube) -> [RebootStep] {
        return cubes.compactMap { step -> RebootStep? in
            guard let i = step.cube.intersection(cube) else { return nil }
            return RebootStep(cube: i, state: step.state.toggled() )
        }
    }

    mutating func add(_ cube: Cube) {
        let intersections = intersctions(cube)
        cubes.append(RebootStep(cube: cube, state: .on))
        cubes.append(contentsOf: intersections)
    }

    mutating func subtract(_ cube: Cube) {
        let intersections = intersctions(cube)
        cubes.append(contentsOf: intersections)
    }
}

public struct SubReactor {

    var cubes = Geometry()

    mutating func boot(steps: [RebootStep], region: Geometry.Cube? = nil) {
        for step in steps {
            guard let cube = step.cube.limit(region) else { continue }
            if Bool(step.state) {
                cubes.add(cube)
            } else {
                cubes.subtract(cube)
            }
        }
    }

    public static func countOn(initialization: String) -> Int {
        let instructions = initialization.lines().map(RebootStep.init)
        let initializationRegion = Geometry.Cube(x: -50...50, y: -50...50, z: -50...50)
        var reactor = SubReactor()
        reactor.boot(steps: instructions, region: initializationRegion)
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
            return RebootStep(cube: .init(x: xRange, y: yRange, z: zRange), state: state)
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
    SubReactor.countOn(reboot: day22_input)
}
