import Foundation
import AdventCore

struct HASHMAP {

  struct Lens: CustomStringConvertible {
    var label: Substring
    var focalLength: Int

    var description: String {
      "[\(label) \(focalLength)]"
    }
  }

  var boxes = Array(repeating: [Lens](), count: 256)

  mutating func initialise(_ instructions: [Substring]) {
    for instruction in instructions {
      let s = Scanner(string: String(instruction))
      guard let label = s.scanCharacters(from: .letters),
            let operation = s.scanCharacter()
      else { continue }
      let hash = calcHash(label[...])
      switch operation {
      case "-":
        boxes[hash].removeAll { $0.label == label }
      case "=":
        guard let focalLength = s.scanInt() else { continue }
        let lens = Lens(label: label[...], focalLength: focalLength)
        if let idx = boxes[hash].firstIndex(where: { $0.label == label }) {
          boxes[hash][idx] = lens
        } else {
          boxes[hash].append(lens)
        }
      default:
        break
      }
    }
  }

  var focussingPower: Int {
    zip(1..., boxes).flatMap { boxIndex, lenses in
      zip(1..., lenses).map { lensIndex, lens in
        boxIndex * lensIndex * lens.focalLength
      }
    }.sum()
  }

}

func calcHash(_ s: Substring) -> Int {
  var hash = 0
  for c in s {
    if let i = c.asciiValue {
      hash += Int(i)
      hash *= 17
      hash %= 256
    }
  }
  return hash
}

public func day15_1(_ input: String) -> Int {
  input.trimmingCharacters(in: .newlines).split(separator: ",").map(calcHash).sum()
}

public func day15_2(_ input: String) -> Int {
  var h = HASHMAP()
  h.initialise(input.trimmingCharacters(in: .newlines).split(separator: ","))
  return h.focussingPower
}
