import XCTest
import AdventCore

final class RegextTests: XCTestCase {

    func testRegexCreation() {
        let r0 = Regex("ab")
        XCTAssertTrue(r0.matches("ab"))
        let r1 = Regex<String>("ab(c)")
        XCTAssertTrue(r1.matches("abc"))
        let r2 = Regex<(String, String)>("ab(c)(d)")
        XCTAssertTrue(r2.matches("abcd"))
    }

    func testRegexMatching() {
        let r0 = Regex("ab")
        XCTAssertEqual(r0.match("ab"), "ab")
        let r1 = Regex<String>("ab(c)")
        XCTAssertEqual(r1.match("abc"), "c")
        let r2 = Regex<(String, String)>("ab(c)(d)")
        let m2 = r2.match("abcd")
        XCTAssertEqual(m2?.0, "c")
        XCTAssertEqual(m2?.1, "d")
    }

    func testRegexTypeMatching() {
        let r1 = Regex<Int>(#"ab(\d+)"#)
        XCTAssertEqual(r1.match("ab123"), 123)
        let r2 = Regex<(Int, Int)>(#"ab(\d)(\d)"#)
        let m2 = r2.match("ab11")
        XCTAssertEqual(m2?.0, 1)
        XCTAssertEqual(m2?.1, 1)
    }

}
