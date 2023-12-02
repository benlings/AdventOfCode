import Foundation
import AdventCore

struct GameRecord {
  var id: Int
  var revealedCubes: [[String: Int]]
}

// Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green

extension Scanner {
  
  func scanCubes() -> [String: Int] {
    var cubes = [String: Int]()
    while !isAtEnd, scanString(";") == nil {
      if let num = scanInt(),
         let colour = scanUpToCharacters(from: CharacterSet(charactersIn: ",;")) {
        cubes[colour] = num
        _ = scanString(",")
      }
    }
    return cubes
  }

  func scanRevealtedCubes() -> [[String: Int]] {
    var reveledCubes = [[String: Int]]()
    while !isAtEnd {
      let cubes = scanCubes()
      if !cubes.isEmpty {
        reveledCubes.append(cubes)
      }
      _ = scanString(";")
    }
    return reveledCubes
  }
}

extension GameRecord {
  init?(_ description: String) {
    let scanner = Scanner(string: description)
    guard let _ = scanner.scanString("Game"),
          let id = scanner.scanInt(),
          let _ = scanner.scanString(":")
    else { return nil }
    self.id = id
    self.revealedCubes = scanner.scanRevealtedCubes()
  }

  var isPossible: Bool {
    revealedCubes.allSatisfy(Self.isPossible(cubes:))
  }

  static func isPossible(cubes: [String: Int]) -> Bool {
    cubes["red", default: 0] <= 12 &&
    cubes["green", default: 0] <= 13 &&
    cubes["blue", default: 0] <= 14
  }
}

// The Elf would first like to know which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?
public func day2_1(_ input: String) -> Int {
  input.lines().compactMap(GameRecord.init).filter(\.isPossible).map(\.id).sum()
}

public func day2_2(_ input: String) -> Int {
    0
}
