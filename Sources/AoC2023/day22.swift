import Foundation
import AdventCore

public func day22_1(_ input: String) -> Int {
  let lines = input.lines().compactMap(Line3D.init).sorted(on: { $0.min(axis: .z) }).indexed()

  var supporting: [Int: Set<Int>] = lines.indices.map { ($0, Set()) }.toDictionary()
  var supportedBy: [Int: Set<Int>] = lines.indices.map { ($0, Set()) }.toDictionary()

  /*
   loop through lines and move them down until they intersect with the ground / stopped items
   When stopped, add the lines to the set of stopped items
   Also keep track of which blocks are supporting it
*/

  var stopped: Set<Offset3D> = []
  var stoppedIds: [Line3D: Int] = [:]

  for (i, var line) in lines {
    // Move line until it's one past its resting place
    while line.min(axis: .z) > 0 && stopped.isDisjoint(with: line.points) {
      line.move(axis: .z, distance: -1)
    }
    let points = Set(line.points)
    // Record support while it's intersecting stopped blocks
    let supportingLines = stoppedIds.filter { !points.isDisjoint(with: $0.key.points) }.map(\.value)
    supportedBy[i, default: []].formUnion(supportingLines)
    for s in supportingLines {
      supporting[s, default: []].insert(i)
    }

    // move line back to its resting place
    line.move(axis: .z, distance: 1)
    stopped.formUnion(line.points)
    stoppedIds[line] = i
  }


   /*
   Can be disintegrated if:
   * it supports no bricks
   * all brick it supports are supported by another brick
   */
  return supporting.count { brick, supporting in
    supporting.isEmpty || supporting.allSatisfy { !supportedBy[$0]!.subtracting([brick]).isEmpty }
  }
}

public func day22_2(_ input: String) -> Int {
  0
}
