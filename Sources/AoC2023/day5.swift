import Foundation
import AdventCore
import SE0270_RangeSet

//seeds: 79 14 55 13
//
//seed-to-soil map:
//50 98 2
//52 50 48
//
//soil-to-fertilizer map:
//0 15 37
//37 52 2
//39 0 15
//
//fertilizer-to-water map:
//49 53 8
//0 11 42
//42 0 7
//57 7 4
//
//water-to-light map:
//88 18 7
//18 25 70
//
//light-to-temperature map:
//45 77 23
//81 45 19
//68 64 13
//
//temperature-to-humidity map:
//0 69 1
//1 0 69
//
//humidity-to-location map:
//60 56 37
//56 93 4

struct RangeMap {
  struct Entry {
    var destinationStart: Int
    var sourceStart: Int
    var length: Int
    var sourceRange: Range<Int> { sourceStart..<(sourceStart + length) }
    func contains(_ source: Int) -> Bool {
      sourceRange.contains(source)
    }
    subscript(source: Int) -> Int {
      assert(sourceRange.contains(source))
      return source - sourceStart + destinationStart
    }
    subscript(range: Range<Int>) -> Range<Int> {
      self[range.lowerBound]..<(self[range.upperBound - 1] + 1)
    }
    func overlappingRange(_ range: Range<Int>) -> Range<Int> {
      self.sourceRange.clamped(to: range)
    }
  }

  var entries: [Entry]

  subscript(source: Int) -> Int {
    if let entry = entries.first(where: { $0.contains(source) }) {
      return entry[source]
    }
    return source
  }

  subscript(sourceRange: RangeSet<Int>) -> RangeSet<Int> {
    // Iterate over ranges + entries to find overlap
    // sourceRange: ---->------<--->------------------<-------
    //     entries: -------->-------<--------->---<-----------
    // destination: ....1111xxxx...xx111111111xxxxx1111.......
    // 1 = 1:1 mapping
    let oneToOne = sourceRange.subtracting(RangeSet(entries.map(\.sourceRange)))
    // x = translate overlapping range with (range) - sourceStart + destinationStart
    var translated = RangeSet<Int>()
    for source in sourceRange.ranges {
      for entry in entries {
        let overlap = entry.overlappingRange(source)
        if !overlap.isEmpty {
          translated.insert(contentsOf: entry[overlap])
        }
      }
    }
    return translated.union(oneToOne)
  }

}

extension Scanner {
  // destStart sourceStart length
  // 50 98 2
  func scanRangeMapEntry() -> RangeMap.Entry? {
    guard let destStart = scanInt(),
          let sourceStart = scanInt(),
          let length = scanInt()
    else { return nil }
    return RangeMap.Entry(destinationStart: destStart, sourceStart: sourceStart, length: length)
  }
}

func parseSeeds(_ line: String) -> [Int] {
  line.trimmingPrefix(#/seeds: /#).split(separator: #/\s+/#).compactMap { Int($0) }
}

func parseRangeMap(_ groups: [String]) -> [RangeMap] {
  groups.map { group in
    var entries = group.lines()
    // Don't need to parse header that specifies `seed-to-soil` etc.
    // The groups are in the order they need to be passed through
    _ = entries.removeFirst()
    return RangeMap(
      entries: entries.compactMap {
        let s = Scanner(string: $0)
        return s.scanRangeMapEntry()
      }
    )
  }
}

public func day5_1(_ input: String) -> Int {
  var groups = input.groups()
  let seeds = parseSeeds(groups.removeFirst())
  let maps = parseRangeMap(groups)
  return seeds.map { seed in
    maps.reduce(seed) { source, map in
      map[source]
    }
  }.min() ?? 0
}

public func day5_2(_ input: String) -> Int {
  var groups = input.groups()
  let seeds = RangeSet(parseSeeds(groups.removeFirst()).chunks(ofCount: 2).compactMap { $0.first!..<($0.first! + $0.last!) })
  let maps = parseRangeMap(groups)
  return maps.reduce(seeds) { source, map in
    map[source]
  }.ranges.first?.lowerBound ?? 0
}
