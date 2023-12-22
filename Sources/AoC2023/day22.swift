import Foundation
import AdventCore

public func day22_1(_ input: String) -> Int {
  let lines = input.lines().compactMap(Line3D.init).sorted(on: { $0.min(axis: .z) }).indexed()
  /*
   loop through lines and move them down until they intersect with the ground / stopped items
   When stopped, add the lines to the set of stopped items
   Also keep track of which blocks are supporting it

   */
  return 0
}

public func day22_2(_ input: String) -> Int {
  0
}
