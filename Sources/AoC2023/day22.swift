import Foundation
import AdventCore

struct Bricks {

  var initialBricks: [Line3D]

  func dropBricks() -> DroppedBricks {
    let bricks = initialBricks.sorted(on: { $0.min(axis: .z) }).indexed()

    /*
     loop through bricks and move them down until they intersect with the ground / stopped items
     When stopped, add the cubes of the brick to the set of stopped items
    */
    var stoppedCubes: Set<Offset3D> = []
    var stoppedIds: [Line3D: Int] = [:]

    // Keep track of which bricks are supporting a brick and supported by a brick
    var droppedBricks = DroppedBricks(brickIds: bricks.indices)

    for (i, var brick) in bricks {
      // Move brick until it's one past its resting place
      while brick.min(axis: .z) > 0 && stoppedCubes.isDisjoint(with: brick.points) {
        brick.move(axis: .z, distance: -1)
      }
      let cubes = Set(brick.points)
      // Record support while it's intersecting stopped cubes
      let supportingBrickIds = stoppedIds.filter { !cubes.isDisjoint(with: $0.key.points) }.map(\.value)
      droppedBricks.add(brick: i, supporting: supportingBrickIds)

      // move brick back to its resting place before recording it in its stopping place
      brick.move(axis: .z, distance: 1)
      stoppedCubes.formUnion(brick.points)
      stoppedIds[brick] = i
    }
    return droppedBricks
  }
}

struct DroppedBricks {
  // bricks above
  var supporting: [Int: Set<Int>]
  // bricks below
  var supportedBy: [Int: Set<Int>]

  init(brickIds: some Sequence<Int>) {
    supporting = brickIds.map { ($0, Set()) }.toDictionary()
    supportedBy = brickIds.map { ($0, Set()) }.toDictionary()
  }

  mutating func add(brick: Int, supporting supportingBricks: some Sequence<Int>) {
    supportedBy[brick, default: []].formUnion(supportingBricks)
    for s in supportingBricks {
      supporting[s, default: []].insert(brick)
    }
  }

  mutating func remove(brick: Int) -> Set<Int> {
    let bricksAbove = supporting[brick]!
    for above in bricksAbove {
      supportedBy[above, default: []].remove(brick)
    }
    for below in supportedBy[brick]! {
      supporting[below, default: []].remove(brick)
    }
    return bricksAbove
  }

  func isBrick(_ brick: Int, onlySupportedBy other: Int) -> Bool {
    !supportedBy[brick]!.subtracting([other]).isEmpty
  }

  var countSafeToDisintegrate: Int {
    /*
     Can be disintegrated if:
     * it supports no bricks
     * all brick it supports are supported by another brick
     */
    return supporting.count { brick, supporting in
      supporting.allSatisfy { isBrick($0, onlySupportedBy: brick) }
    }
  }

  func chainReaction(brick: Int) -> Int {
    var removed = Set<Int>()
    var copy = self
    var toRemove = [[brick]]
    while let r = toRemove.popLast() {
      guard !r.isEmpty else { continue }
      let above = r.map {
        removed.insert($0)
        return copy.remove(brick: $0)
      }
      toRemove.append(contentsOf: above.map {
        $0.filter { copy.supportedBy[$0]!.isEmpty }
      })
    }
    return removed.count - 1
  }

  var chainReactionTotal: Int {
    return supporting.map { brick, s in
      if s.allSatisfy({ !supportedBy[$0]!.subtracting([brick]).isEmpty }) {
        return 0
      }
      return chainReaction(brick: brick)
    }.sum()
  }

}

extension Bricks {
  init(_ description: String) {
    initialBricks = description.lines().compactMap(Line3D.init)
  }
}

public func day22_1(_ input: String) -> Int {
  Bricks(input).dropBricks().countSafeToDisintegrate
}

public func day22_2(_ input: String) -> Int {
  Bricks(input).dropBricks().chainReactionTotal
}
