//
//  File.swift
//  
//
//  Created by Ben Lings on 24/12/2020.
//

import Foundation

protocol GameOfLife {
    associatedtype Coordinate : Hashable

    typealias World = Set<Coordinate>

    var initialWorld: World { get }

    func neighbours(coordinate: Coordinate) -> [Coordinate]

    func alive(wasAlive alive: Bool, neighbours count: Int) -> Bool
}

extension GameOfLife {

    func step(world: World) -> World {
        var neighbourCounts = [Coordinate : Int]()
        for point in world {
            for neighbour in neighbours(coordinate: point) {
                neighbourCounts[neighbour, default: 0] += 1
            }
        }
        var newWorld = World()
        for (point, count) in neighbourCounts {
            if alive(wasAlive: world.contains(point), neighbours: count) {
                newWorld.insert(point)
            }
        }
        return newWorld
    }

    func run(iterations: Int) -> World {
        (0..<iterations).reduce(initialWorld) { w, _ in step(world: w) }
    }

    func aliveCount(iterations: Int) -> Int {
        run(iterations: iterations).count
    }
}
