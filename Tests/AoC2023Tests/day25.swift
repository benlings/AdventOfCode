import XCTest
import AoC2023

final class Day25Tests: XCTestCase {

  let input = Bundle.module.text(named: "day25")

  let exampleInput = """
  jqt: rhn xhk nvd
  rsh: frs pzl lsr
  xhk: hfx
  cmg: qnr nvd lhk bvb
  rhn: xhk bvb hfx
  bvb: xhk hfx
  pzl: lsr hfx nvd
  qnr: nvd
  ntq: jqt hfx bvb xhk
  nvd: lhk
  lsr: lhk
  rzs: qnr cmg lsr rsh
  frs: qnr lhk lsr
  """

  func testPart1Example() {
    XCTAssertEqual(day25_1(exampleInput), 54)
  }

  func testPart1() {
    XCTAssertEqual(day25_1(input), 582590)
  }

  func testPart2Example() {
    XCTAssertEqual(day25_2(exampleInput), 0)
  }

  func testPart2() {
    XCTAssertEqual(day25_2(input), 0)
  }
}
