import Foundation
import AdventCore

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

public func day23_2() -> Int {
    0
}
