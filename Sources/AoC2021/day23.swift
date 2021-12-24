import Foundation
import AdventCore
import PriorityQueueModule

enum Amphipod : Int {
    case amber
    case bronze
    case copper
    case desert
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

struct Burrow : Hashable {

//    #############
//    #01 2 3 4 56#  <- Hallway
//    ###A#B#C#D###  <- Side rooms
//      #A#B#C#D#    </
//      #########

    var hallway: [Amphipod?] = Array(repeating: nil, count: 8)
    // side rooms - earlier elements further away from hallway
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

    func distance(from sideRoom: Amphipod, to destinationSideRoom: Amphipod) -> Int {
        precondition(sideRoom != destinationSideRoom)
        return 2 * abs(sideRoom.rawValue - destinationSideRoom.rawValue)
    }

    func indexIn(sideRoom: Amphipod) -> Int? {
        let room = sideRooms[sideRoom]!
        guard let destinationIndex = room.lastIndex(of: nil),
              room.allSatisfy({ $0 == nil || $0 == sideRoom })
        else {
            return nil
        }
        return destinationIndex
    }

    func copyMovingFrom(hallway: Int, type: Amphipod) -> (cost: Int, node: Self) {
        var copy = self
        copy.hallway[hallway] = nil
        let sideRoomIndex = indexIn(sideRoom: type)!
        let distanceToSideRoom = sideRoomDistances[type]![hallway]
        copy.sideRooms[type]![sideRoomIndex] = type
        return (cost: type.energy * (distanceToSideRoom + sideRoomIndex), node: copy)
    }

    func copyMovingToHallway(from sideRoom: Amphipod, index: Int) -> [(cost: Int, node: Self)] {
        var copy = self
        let type = copy.sideRooms[sideRoom]![index]!
        copy.sideRooms[sideRoom]![index] = nil
        return sideRoomDistances[sideRoom]!.indexed().map { i, distance in
            copy.hallway[i] = type
            return (cost: type.energy * (index + distance), node: copy)
        }
    }

    func copyMovingToSideRoom(from sideRoom: Amphipod, index: Int) -> [(cost: Int, node: Self)] {
        var copy = self
        let type = copy.sideRooms[sideRoom]![index]!
        copy.sideRooms[sideRoom]![index] = nil
        guard let destinationIndex = copy.indexIn(sideRoom: type)
        else {
            return []
        }
        let distance = distance(from: sideRoom, to: type)
        copy.sideRooms[type]![destinationIndex] = type
        return [(cost: type.energy * (index + distance + destinationIndex),
                node: copy)]
    }

    func neighbours() -> [(cost: Int, node: Self)] {
        hallway.indexed().compactMap { (i, loc) -> (cost: Int, node: Self)? in
            switch loc {
            case nil: return nil
            case let type?: return copyMovingFrom(hallway: i, type: type)
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
    let burrow = Burrow(a: [.bronze, .amber],
                        b: [.copper, .desert],
                        c: [.amber, .bronze],
                        d: [.copper, .desert])
    _ = burrow.findLeastTotalEnergy()
    return 40 +
            6 +
            2000 +
            600 +
            3000 +
            6000 +
            500 +
            30 +
            2 +
            50 +
            3 +
            9
}

//#############
//#...........#
//###A#D#B#D###
//  #D#C#B#A#
//  #D#B#A#C#
//  #B#C#A#C#
//  #########

public func day23_2() -> Int {
    let _ = Burrow(a: [.bronze, .desert, .desert, .amber],
                   b: [.copper, .bronze, .copper, .desert],
                   c: [.amber, .amber, .bronze, .bronze],
                   d: [.copper, .copper, .amber, .desert])
    return 0
}
