import Foundation
import AdventCore
import Collections

// Track destination valve and expected timestep. can then step each person independently?
// Or separate state for each person somehow?

struct ValveState : Hashable {
    var currentValve: String = "AA"
    var elephantValve: String = "AA"
    var flowRates: [String : Int]

    var currentFlowRate: Int {
        get { flowRates[currentValve]! }
        set { flowRates[currentValve] = newValue }
    }

    var elephantFlowRate: Int {
        get { flowRates[elephantValve]! }
        set { flowRates[elephantValve] = newValue }
    }

    mutating func turnOnValve(_ remaining: Int) -> Int? {
        let rate = currentFlowRate
        guard rate > 0 else { return nil }
        currentFlowRate = 0
        return rate * remaining
    }

    mutating func moveTo(valve: String) {
        currentValve = valve
    }
}

public struct ValveScan {

    var tunnels: [String : [String]]
    var startingState: ValveState
    var withElephant: Bool

    public func maxPressureRelease() -> Int {
        findLargestRelease(start: startingState)!
    }

    func findNeighbourStates(start: ValveState, remaining: Int) -> [(release: Int, ValveState, remaining: Int)] {
        var neighbours = [(Int, ValveState, Int)]()

        if withElephant {
            for me in [start.currentValve] + tunnels[start.currentValve]! {
                for elephant in [start.elephantValve] + tunnels[start.elephantValve]! {
                    var next = start
                    var release = 0

                    if me == start.currentValve {
                        let rate = next.currentFlowRate
                        guard rate > 0 else { continue }
                        next.currentFlowRate = 0
                        release += rate * (remaining - 1)
                    } else {
                        next.currentValve = me
                    }

                    if elephant == start.elephantValve && elephant != me {
                        let rate = next.elephantFlowRate
                        guard rate > 0 else { continue }
                        next.elephantFlowRate = 0
                        release += rate * (remaining - 1)
                    } else {
                        next.elephantValve = elephant
                    }
                    if remaining > 0 {
                        neighbours.append((release, next, remaining - 1))
                    }
                }
            }
        } else {
            var turnedOn = start
            if let release = turnedOn.turnOnValve(remaining - 1), remaining > 0 {
                neighbours.append((release, turnedOn, remaining - 1))
            }
            for exit in tunnels[start.currentValve]! {
                var next = start
                var prev = next.currentValve
                next.moveTo(valve: exit)
                var r = remaining - 1
                // Follow tunnels with no choices (another exit or valve to turn on)
                while next.currentFlowRate == 0 && tunnels[next.currentValve]!.count == 2 {
                    let following = tunnels[next.currentValve]!.first { $0 != prev }!
                    prev = next.currentValve
                    next.moveTo(valve: following)
                    r -= 1
                }
                if r >= 0 {
                    neighbours.append((0, next, r))
                }
            }
        }
        return neighbours
    }

    func findLargestRelease(start: ValveState) -> Int? {
        var remaining = [start: withElephant ? 26 : 30]
        var release = [start: 0]
        var toVisit = [start] as Deque<ValveState>
        while let current = toVisit.popFirst() {
            let currentRelease = release[current]!
            let r = remaining[current]!
            for (neighbourRelease, neighbour, nr) in findNeighbourStates(start: current, remaining: r) {
                let alt = currentRelease + neighbourRelease
                if alt > release[neighbour, default: .min] {
                    release[neighbour] = alt
                    remaining[neighbour] = nr
                    toVisit.append(neighbour)
                }
            }
        }
        return release.values.max()
    }

}

public extension ValveScan {
    init(_ input: some Sequence<String>, withElephant: Bool = false) {
        startingState = ValveState(flowRates: [:])
        tunnels = [:]
        self.withElephant = withElephant
        for line in input {
            let scanner = Scanner(string: line)
            guard let _ = scanner.scanString("Valve"),
                  let valve = scanner.scanCharacters(from: .uppercaseLetters),
                  let _ = scanner.scanString("has flow rate="),
                  let rate = scanner.scanInt(),
                  scanner.scanString("; tunnels lead to valves") != nil || scanner.scanString("; tunnel leads to valve") != nil,
                  case let dest = scanner.scanSequence(separator: ",", scanElement: { $0.scanCharacters(from: .uppercaseLetters) })
            else { continue }
            startingState.flowRates[valve] = rate
            tunnels[valve] = dest
        }
    }
}

fileprivate let day16_input = Bundle.module.text(named: "day16").lines()

public func day16_1() -> Int {
    ValveScan(day16_input).maxPressureRelease()
}

public func day16_2() -> Int {
    ValveScan(day16_input, withElephant: true).maxPressureRelease()
}
