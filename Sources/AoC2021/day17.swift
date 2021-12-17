import Foundation
import AdventCore

struct Probe {
    var position: Offset = .zero
    var velocity: Offset

    mutating func step() {
        position += velocity
        var velocityChange = Offset(east: 0, north: -1)
        if velocity.east > 0 {
            velocityChange.east = -1
        } else if velocity.east < 0 {
            velocityChange.east = 1
        }
        velocity += velocityChange
    }

    mutating func stepUntilIn(targetHeight: ClosedRange<Int>) -> Int? {
        var maxHeight = position.north
        repeat {
            step()
            print(position.north)
            maxHeight = max(maxHeight, position.north)
            if targetHeight.contains(position.north) {
                return maxHeight
            }
        } while position.north >= targetHeight.lowerBound
        return nil
    }
}

public struct ProbeToss {
    public init(targetHeight: ClosedRange<Int>) {
        self.targetHeight = targetHeight
    }

    var targetHeight: ClosedRange<Int>

    public func maxHeight() -> Int {
        // Highest y velocity it can be going at and still bein in the target
        let maxInitialVelocity = -targetHeight.lowerBound - 1
        let maxHeight = maxInitialVelocity * (maxInitialVelocity + 1)/2
        return maxHeight
    }
}

// target area: x=269..292, y=-68..-44
fileprivate let day17_input = Bundle.module.text(named: "day17").lines()

public func day17_1() -> Int {
    let probe = ProbeToss(targetHeight: (-68)...(-44))
    return probe.maxHeight()
}

public func day17_2() -> Int {
    0
}
