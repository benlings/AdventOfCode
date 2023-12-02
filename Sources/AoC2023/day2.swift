import Foundation
import AdventCore

struct GameRecord {

  enum Colour: String {
    case red, green, blue
  }

  var id: Int
  var revealedCubes: [[Colour: Int]]
}

// Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green

extension Scanner {
  
  func scanCubes() -> [GameRecord.Colour: Int] {
    var cubes = [GameRecord.Colour: Int]()
    while !isAtEnd, scanString(";") == nil {
      if let num = scanInt(),
         let c = scanUpToCharacters(from: CharacterSet(charactersIn: ",;")),
         let colour = GameRecord.Colour(rawValue: c) {
        cubes[colour] = num
        _ = scanString(",")
      }
    }
    return cubes
  }

  func scanRevealtedCubes() -> [[GameRecord.Colour: Int]] {
    var reveledCubes = [[GameRecord.Colour: Int]]()
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

  // The Elf would first like to know which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes?
  static func isPossible(cubes: [GameRecord.Colour: Int]) -> Bool {
    cubes[.red, default: 0] <= 12 &&
    cubes[.green, default: 0] <= 13 &&
    cubes[.blue, default: 0] <= 14
  }

  var fewestCubes: [GameRecord.Colour: Int] {
    revealedCubes.reduce(into: [:]) { result, cubes in
      result[.red, default: 0].formMax(cubes[.red, default: 0])
      result[.green, default: 0].formMax(cubes[.green, default: 0])
      result[.blue, default: 0].formMax(cubes[.blue, default: 0])
    }
  }

  var power: Int {
    fewestCubes.values.product()
  }
}

public func day2_1(_ input: String) -> Int {
  input.lines().compactMap(GameRecord.init).filter(\.isPossible).map(\.id).sum()
}

public func day2_2(_ input: String) -> Int {
  input.lines().compactMap(GameRecord.init).map(\.power).sum()
}
