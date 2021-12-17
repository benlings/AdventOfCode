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

    mutating func stepUntilIn(targetX: ClosedRange<Int>, targetY: ClosedRange<Int>) -> Bool {
        repeat {
            step()
            if targetY.contains(position.north) && targetX.contains(position.east) {
                return true
            }
        } while position.north >= targetY.lowerBound && position.east <= targetX.upperBound
        return false
    }
}

public struct ProbeToss {
    public init(targetX: ClosedRange<Int>, targetY: ClosedRange<Int>) {
        self.targetX = targetX
        self.targetY = targetY
    }

    var targetX: ClosedRange<Int>
    var targetY: ClosedRange<Int>

    private func triangular(_ n: Int) -> Int {
        n * (n + 1)/2
    }

    private func inv_triangular(_ n: Int) -> Double {
        // y = x (x + 1) / 2
        // x^2 + x - 2y = 0
        // x = (-1 +- sqrt(1 + 8y))/2
        // ignore negative solution
        (sqrt(Double(1 + 8 * n)) - 1)/2
    }

    public func maxHeight() -> Int {
        // Highest y velocity it can be going at and still bein in the target
        let maxInitialVelocity = -targetY.lowerBound - 1
        let maxHeight = triangular(maxInitialVelocity)
        return maxHeight
    }

    public func countIntialVelocities() -> Int {
        let initialXVelocityRange = Int(inv_triangular(targetX.lowerBound).rounded(.up))...targetX.upperBound
        let initialYVelocityRange = targetY.lowerBound...(-targetY.lowerBound - 1)
        var count = 0;
        for x in initialXVelocityRange {
            for y in initialYVelocityRange {
                var probe = Probe(velocity: Offset(east: x, north: y))
                if (probe.stepUntilIn(targetX: targetX, targetY: targetY)) {
                    count += 1
                }
            }
        }
        return count
    }
}

// target area: x=269..292, y=-68..-44
fileprivate let day17_input = ProbeToss(targetX: 269...292, targetY: (-68)...(-44))

public func day17_1() -> Int {
    return day17_input.maxHeight()
}

public func day17_2() -> Int {
    day17_input.countIntialVelocities()
}
