import Foundation
import AdventCore

enum Amphipod : Int, Comparable {
    case amber
    case bronze
    case copper
    case desert

    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension Amphipod {
    var energy: Int {
        switch self {
        case .amber: return 1
        case .bronze: return 10
        case .copper: return 100
        case .desert: return 1000
        }
    }
}

extension Amphipod : CustomStringConvertible {
    var description: String {
        switch self {
        case .amber: return "A"
        case .bronze: return "B"
        case .copper: return "C"
        case .desert: return "D"
        }
    }
}

struct Burrow : Hashable {

//    #############
//    #01 2 3 4 56#  <- Hallway
//    ###A#B#C#D###  <- Side rooms
//      #A#B#C#D#    </
//      #########

    var hallway: [Amphipod?] = Array(repeating: nil, count: 7)
    // side rooms - earlier elements closer to hallway
    var sideRooms: [Amphipod : [Amphipod?]] = [
        .amber : [],
        .bronze : [],
        .copper : [],
        .desert : [],
    ]

    init(a: [Amphipod], b: [Amphipod], c: [Amphipod], d: [Amphipod]) {
        sideRooms[.amber]?.append(contentsOf: a)
        sideRooms[.bronze]?.append(contentsOf: b)
        sideRooms[.copper]?.append(contentsOf: c)
        sideRooms[.desert]?.append(contentsOf: d)
    }

    static func organized(_ count: Int) -> Self {
        Self(a: Array(repeating: .amber, count: count),
             b: Array(repeating: .bronze, count: count),
             c: Array(repeating: .copper, count: count),
             d: Array(repeating: .desert, count: count))
    }

    let sideRoomDistances: [Amphipod : [Int]] = [
        .amber: [3,2,2,4,6,8,9],
        .bronze: [5,4,2,2,4,6,7],
        .copper: [7,6,4,2,2,4,5],
        .desert: [9,8,6,4,2,2,3],
    ]

    func sideRoomPosition(sideRoom: Amphipod) -> Int {
        sideRoom.rawValue + 2
    }

    func distanceBetween(sideRoom: Amphipod, hallway: Int) -> Int? {
        let p = sideRoomPosition(sideRoom: sideRoom)
        if hallway < p {
            if self.hallway[hallway..<p].contains(where: { $0 != nil }) {
                return nil
            }
        } else {
            if self.hallway[p...hallway].contains(where: { $0 != nil }) {
                return nil
            }
        }
        return sideRoomDistances[sideRoom]![hallway]
    }

    //    #############
    //    #01 2 3 4 56#  <- Hallway
    //    ###A#B#C#D###  <- Side rooms
    //      #A#B#C#D#    </
    //      #########

    func distance(from sideRoom: Amphipod, to destinationSideRoom: Amphipod) -> Int? {
        precondition(sideRoom != destinationSideRoom)
        let lower = sideRoomPosition(sideRoom: min(sideRoom, destinationSideRoom))
        let upper = sideRoomPosition(sideRoom: max(sideRoom, destinationSideRoom))
        if self.hallway[lower..<upper].contains(where: { $0 != nil }) {
            return nil
        }
        return 2 + 2 * abs(sideRoom.rawValue - destinationSideRoom.rawValue)
    }

    func destinationIndexIn(sideRoom: Amphipod) -> Int? {
        let room = sideRooms[sideRoom]!
        guard let destinationIndex = room.lastIndex(of: nil),
              room.allSatisfy({ $0 == nil || $0 == sideRoom })
        else {
            return nil
        }
        return destinationIndex
    }

    func copyMovingFrom(hallway: Int, type: Amphipod) -> (cost: Int, node: Self)? {
        var copy = self
        copy.hallway[hallway] = nil
        guard let distanceToSideRoom = copy.distanceBetween(sideRoom: type, hallway: hallway),
              let sideRoomIndex = copy.destinationIndexIn(sideRoom: type)
        else { return nil }
        copy.sideRooms[type]![sideRoomIndex] = type
        return (cost: type.energy * (distanceToSideRoom + sideRoomIndex), node: copy)
    }

    func copyMovingToHallway(from sideRoom: Amphipod, index: Int) -> [(cost: Int, node: Self)] {
        let type = sideRooms[sideRoom]![index]!
        return hallway.indices.compactMap { i in
            var copy = self
            copy.sideRooms[sideRoom]![index] = nil
            guard let distance = copy.distanceBetween(sideRoom: sideRoom, hallway: i)
            else { return nil }
            copy.hallway[i] = type
            return (cost: type.energy * (index + distance), node: copy)
        }
    }

    func copyMovingToSideRoom(from sideRoom: Amphipod, index: Int) -> [(cost: Int, node: Self)] {
        let type = sideRooms[sideRoom]![index]!
        guard type != sideRoom else { return [] } // Can't move to same side room
        guard let destinationIndex = destinationIndexIn(sideRoom: type),
              let distance = distance(from: sideRoom, to: type)
        else { return [] }
        var copy = self
        copy.sideRooms[sideRoom]![index] = nil
        copy.sideRooms[type]![destinationIndex] = type
        return [(cost: type.energy * (index + distance + destinationIndex),
                node: copy)]
    }

    func neighbours() -> [(cost: Int, node: Self)] {
        hallway.indexed().compactMap { (i, loc) -> (cost: Int, node: Self)? in
            switch loc {
            case nil: return nil // Nothing at this index
            case let type?: return copyMovingFrom(hallway: i, type: type) // Can only move from hallway to own side room
            }
        } + sideRooms.flatMap { sideRoom, locs -> [(cost: Int, node: Self)] in
            guard let index = locs.firstIndex(where: { $0 != nil}) else { return [] }
            return copyMovingToHallway(from: sideRoom, index: index) +
            copyMovingToSideRoom(from: sideRoom, index: index)
        }
    }

    func findLowestRiskPath(start: Burrow, end: Burrow) -> Int? {
        var costs = [start: 0]
        var toVisit = [start: 0] as PriorityQueue
        while let current = toVisit.popMin() {
            let currentCost = costs[current, default: .max]
            for (neighbourCost, neighbour) in current.neighbours() {
                let alt = currentCost + neighbourCost
                if alt < costs[neighbour, default: .max] {
                    costs[neighbour] = alt
                    toVisit.insert(neighbour, priority: alt)
                }
            }
        }
        return costs[end]
    }

    public func findLeastTotalEnergy() -> Int {
        findLowestRiskPath(start: self, end: .organized(self.sideRooms[.amber]!.count))!
    }
}

extension Optional where Wrapped == Amphipod {
    var s: String {
        self?.description ?? "."
    }
}

extension Burrow : CustomStringConvertible {
    var description: String {
        (["\(hallway[0].s)\(hallway[1].s).\(hallway[2].s).\(hallway[3].s).\(hallway[4].s).\(hallway[5].s)\(hallway[6].s)"] +
        sideRooms[.amber]!.indices.map { i -> String in
            "  \(sideRooms[.amber]![i].s) \(sideRooms[.bronze]![i].s) \(sideRooms[.copper]![i].s) \(sideRooms[.desert]![i].s)"
        }).joined(separator: "\n")
    }
}

fileprivate let day23_input = Bundle.module.text(named: "day23").lines()

// #############
// #...........#
// ###A#D#B#D###
//   #B#C#A#C#
//   #########
//
// 40
// 6
// 2000
// 600
// 3000
// 6000
// 500
//
// #############
// #...B......A#
// ###A#.#C#D###
//   #B#.#C#D#
//   #########
//
// 30
// 2
// 50
// 3
// 9

public func day23_1() -> Int {
    let burrow = Burrow(a: [.amber, .bronze],
                        b: [.desert, .copper],
                        c: [.bronze, .amber],
                        d: [.desert, .copper])
    return burrow.findLeastTotalEnergy()
}

//#############
//#...........#
//###A#D#B#D###
//  #D#C#B#A#
//  #D#B#A#C#
//  #B#C#A#C#
//  #########

public func day23_2() -> Int {
    let burrow = Burrow(a: [.amber, .desert, .desert, .bronze],
                        b: [.desert, .copper, .bronze, .copper],
                        c: [.bronze, .bronze, .amber, .amber],
                        d: [.desert, .amber, .copper, .copper])
    return burrow.findLeastTotalEnergy()
}
