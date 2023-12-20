import Foundation
import AdventCore
import Collections

struct ValveState : Hashable {
    var currentValve: String = "AA"
    var elephantValve: String = "AA"
    var flowRates: [String : Int]
    var remaining: Int

    var currentFlowRate: Int {
        get { flowRates[currentValve]! }
        set { flowRates[currentValve] = newValue }
    }

    var elephantFlowRate: Int {
        get { flowRates[elephantValve]! }
        set { flowRates[elephantValve] = newValue }
    }

    mutating func turnOnValve() -> Int? {
        let rate = currentFlowRate
        guard rate > 0 else { return nil }
        remaining -= 1
        currentFlowRate = 0
        return rate * remaining
    }

    mutating func moveTo(valve: String) {
        currentValve = valve
        remaining -= 1
    }
}

struct ValveScan {

    var tunnels: [String : [String]]
    var startingState: ValveState
    var withElephant: Bool

    func maxPressureRelease() -> Int {
        findLargestRelease(start: startingState)!
    }

    func findNeighbourStates(start: ValveState) -> [(release: Int, ValveState)] {
        var neighbours = [(Int, ValveState)]()

        if withElephant {
            for me in [start.currentValve] + tunnels[start.currentValve]! {
                for elephant in [start.elephantValve] + tunnels[start.elephantValve]! {
                    var next = start
                    var release = 0
                    next.remaining -= 1

                    if me == start.currentValve {
                        let rate = next.currentFlowRate
                        guard rate > 0 else { continue }
                        next.currentFlowRate = 0
                        release += rate * next.remaining
                    } else {
                        next.currentValve = me
                    }

                    if elephant == start.elephantValve && elephant != me {
                        let rate = next.elephantFlowRate
                        guard rate > 0 else { continue }
                        next.elephantFlowRate = 0
                        release += rate * next.remaining
                    } else {
                        next.elephantValve = elephant
                    }
                    if next.remaining >= 0 {
                        neighbours.append((release, next))
                    }
                }
            }
        } else {
            var turnedOn = start
            if let release = turnedOn.turnOnValve(), turnedOn.remaining >= 0 {
                neighbours.append((release, turnedOn))
            }
            for exit in tunnels[start.currentValve]! {
                var next = start
                var prev = next.currentValve
                next.moveTo(valve: exit)
                // Follow tunnels with no choices (another exit or valve to turn on)
                while next.currentFlowRate == 0 && tunnels[next.currentValve]!.count == 2 {
                    let following = tunnels[next.currentValve]!.first { $0 != prev }!
                    prev = next.currentValve
                    next.moveTo(valve: following)
                }
                if next.remaining >= 0 {
                    neighbours.append((0, next))
                }
            }
        }
        return neighbours
    }

    func findLargestRelease(start: ValveState) -> Int? {
        var release = [start: 0]
        var toVisit = [start] as Deque<ValveState>
        while let current = toVisit.popFirst() {
            let currentRelease = release[current]!
            for (neighbourRelease, neighbour) in findNeighbourStates(start: current) {
                let alt = currentRelease + neighbourRelease
                if alt > release[neighbour, default: .min] {
                    release[neighbour] = alt
                    toVisit.append(neighbour)
                }
            }
        }
        return release.values.max()
    }

}

extension ValveScan {
    init(_ input: some Sequence<String>, withElephant: Bool = false) {
        startingState = ValveState(flowRates: [:], remaining: withElephant ? 26 : 30)
        tunnels = [:]
        self.withElephant = withElephant
        for line in input {
            let scanner = Scanner(string: line)
            guard let _ = scanner.scanString("Valve"),
                  let valve = scanner.scanCharacters(from: .uppercaseLetters),
                  let _ = scanner.scanString("has flow rate="),
                  let rate = scanner.scanInt(),
                  scanner.scanString("; tunnels lead to valves") != nil || scanner.scanString("; tunnel leads to valve") != nil,
                  case let dest = scanner.scanSequence(separator: ",", scanElement: { scanner.scanCharacters(from: .uppercaseLetters) })
            else { continue }
            startingState.flowRates[valve] = rate
            tunnels[valve] = dest
        }
    }
}

public func day16_1(_ input: [String]) -> Int {
    ValveScan(input).maxPressureRelease()
}

public func day16_2(_ input: [String]) -> Int {
    ValveScan(input, withElephant: true).maxPressureRelease()
}
