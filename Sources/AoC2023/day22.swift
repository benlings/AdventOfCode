import Foundation
import AdventCore

struct Bricks {

  var initialBricks: [Line3D]

  func dropBricks() -> (supporting: [Int: Set<Int>], supportedBy: [Int: Set<Int>]) {
    let bricks = initialBricks.sorted(on: { $0.min(axis: .z) }).indexed()

    /*
     loop through bricks and move them down until they intersect with the ground / stopped items
     When stopped, add the cubes of the brick to the set of stopped items
    */
    var stoppedCubes: Set<Offset3D> = []
    var stoppedIds: [Line3D: Int] = [:]

    // Keep track of which bricks are supporting a brick and supported by a brick
    var supporting: [Int: Set<Int>] = bricks.indices.map { ($0, Set()) }.toDictionary()
    var supportedBy: [Int: Set<Int>] = bricks.indices.map { ($0, Set()) }.toDictionary()

    for (i, var brick) in bricks {
      // Move brick until it's one past its resting place
      while brick.min(axis: .z) > 0 && stoppedCubes.isDisjoint(with: brick.points) {
        brick.move(axis: .z, distance: -1)
      }
      let cubes = Set(brick.points)
      // Record support while it's intersecting stopped cubes
      let supportingBrickIds = stoppedIds.filter { !cubes.isDisjoint(with: $0.key.points) }.map(\.value)
      supportedBy[i, default: []].formUnion(supportingBrickIds)
      for s in supportingBrickIds {
        supporting[s, default: []].insert(i)
      }

      // move brick back to its resting place before recording it in its stopping place
      brick.move(axis: .z, distance: 1)
      stoppedCubes.formUnion(brick.points)
      stoppedIds[brick] = i
    }
    return (supporting, supportedBy)
  }

  var countSafeToDisintegrate: Int {
    let (supporting, supportedBy) = dropBricks()
    /*
     Can be disintegrated if:
     * it supports no bricks
     * all brick it supports are supported by another brick
     */
    return supporting.count { brick, supporting in
      supporting.isEmpty || supporting.allSatisfy { !supportedBy[$0]!.subtracting([brick]).isEmpty }
    }
  }
}

extension Bricks {
  init(_ description: String) {
    initialBricks = description.lines().compactMap(Line3D.init)
  }
}

public func day22_1(_ input: String) -> Int {
  let bricks = Bricks(input)
  return bricks.countSafeToDisintegrate
}

public func day22_2(_ input: String) -> Int {
  0
}
