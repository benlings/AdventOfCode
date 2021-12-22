import Foundation
import AdventCore

struct RebootStep {
    var xRange: ClosedRange<Int>
    var yRange: ClosedRange<Int>
    var zRange: ClosedRange<Int>
    var state: Bit
}

public struct SubReactor {

    var cubes = Set<Offset3D>()

    let limit = -50..<51

    func limit(_ range: ClosedRange<Int>) -> Range<Int> {
        (range.lowerBound..<(range.upperBound + 1)).clamped(to: limit)
    }

    mutating func boot(steps: [RebootStep]) {
        for step in steps {
            for x in limit(step.xRange) {
                for y in limit(step.yRange) {
                    for z in limit(step.zRange) {
                        let offset = Offset3D(x: x, y: y, z: z)
                        if Bool(step.state) {
                            cubes.insert(offset)
                        } else {
                            cubes.remove(offset)
                        }
                    }
                }
            }
        }
    }

    public static func countOn(initialization: String) -> Int {
        let instructions = initialization.lines().map(RebootStep.init)
        var reactor = SubReactor()
        reactor.boot(steps: instructions)
        return reactor.cubes.count
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
