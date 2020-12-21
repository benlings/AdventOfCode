import XCTest
import AoC2020

final class Day21Tests: XCTestCase {

    func testPart1Example() {
        let input = """
        mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
        trh fvjkl sbzzf mxmxvkd (contains dairy)
        sqjhc fvjkl (contains soy)
        sqjhc mxmxvkd sbzzf (contains fish)
        """
        let foods = FoodList(input)
        XCTAssertEqual(foods.knownSafeIngredients(), ["kfcds", "nhms", "sbzzf", "trh"])
    }

    func testPart1() {
        XCTAssertEqual(day21_1(), 0)
    }

    func testPart2() {
        XCTAssertEqual(day21_2(), 0)
    }
}
