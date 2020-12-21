import XCTest
import AoC2020

final class Day21Tests: XCTestCase {

    let exampleFoods = FoodList("""
    mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
    trh fvjkl sbzzf mxmxvkd (contains dairy)
    sqjhc fvjkl (contains soy)
    sqjhc mxmxvkd sbzzf (contains fish)
    """)

    func testPart1Example() {
        XCTAssertEqual(exampleFoods.knownSafeIngredients(), ["kfcds", "nhms", "sbzzf", "trh"])
        XCTAssertEqual(exampleFoods.countSafeIngredients(), 5)
    }

    func testPart1() {
        XCTAssertEqual(day21_1(), 2517)
    }

    func testPart2Example() {
        XCTAssertEqual(exampleFoods.canonicalDangerousIngredients(), "mxmxvkd,sqjhc,fvjkl")
    }

    func testPart2() {
        XCTAssertEqual(day21_2(), "rhvbn,mmcpg,kjf,fvk,lbmt,jgtb,hcbdb,zrb")
    }
}
