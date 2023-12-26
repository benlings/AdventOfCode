import Foundation
import AdventCore

struct Graph<Vertex: Hashable> {
  typealias Edge = (u: Vertex, w: Vertex)
  var V: Set<Vertex>
  var edges: [Edge]
  func find(_ parent: [Vertex: Vertex], _ i: Vertex) -> Vertex {
    if (parent[i] == i) {
      return i
    }
    return find(parent, parent[i]!)
  }
  func unionSets(_ parent: inout [Vertex: Vertex], _ rank: inout [Vertex: Int], x: Vertex, y: Vertex) {
    let xroot = find(parent, x);
    let yroot = find(parent, y);

    if rank[xroot, default: 0] < rank[yroot, default: 0] {
      parent[xroot] = yroot;
    } else if rank[xroot, default: 0] > rank[yroot, default: 0] {
      parent[yroot] = xroot;
    } else {
      parent[yroot] = xroot;
      rank[xroot, default: 0] += 1;
    }
  }

  init(_ edges: [Edge]) {
    V = edges.flatMap { [$0.0, $0.1] }.toSet()
    self.edges = edges
  }

  func kargerMinCut() -> (cuts: Int, counts: [Int]) {
    var parent = V.map { ($0, $0) }.toDictionary()
    var rank = [Vertex: Int]()
    var v = V.count
    var edges = edges
    while v > 2 {
      let randomIndex = edges.indices.randomElement()!
      let (u, w) = edges.remove(at: randomIndex)
      let setU = find(parent, u)
      let setW = find(parent, w)
      if (setU != setW) {
        v -= 1
        unionSets(&parent, &rank, x: setU, y: setW)
      }
    }
    var minCut = 0;
    for edge in edges {
      let setU = find(parent, edge.u)
      let setW = find(parent, edge.w)
      if (setU != setW) {
        minCut += 1
      }
    }
    var counts = [Vertex: Int]()
    for v in V {
      let setV = find(parent, v)
      counts[setV, default: 0] += 1
    }
    return (minCut, Array(counts.values));
  }
}

public func day25_1(_ input: String) -> Int {
  let edges = input.lines().flatMap { line in
    let vs = line.split(separator: #/[ :]+/#)
    let v = vs[0]
    return vs.dropFirst().map { (v, $0) }
  }
  let graph = Graph(edges)
  while true {
    let (k, c) = graph.kargerMinCut()
    if k == 3 {
      return c.product()
    }
  }
}

public func day25_2(_ input: String) -> Int {
  0
}
