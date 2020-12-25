import Foundation
import AdventCore

struct Food {
    var ingredients = Set<String>()
    var alergens = Set<String>()
}

extension Food {
    init(_ description: String) {
        let scanner = Scanner(string: description)
        while let ingredient = scanner.scanUpToCharacters(from: .whitespaces) {
            if ingredient.starts(with: "(contains") {
                break
            }
            ingredients.insert(ingredient)
        }
        while let alergen = scanner.scanUpToCharacters(from: CharacterSet(charactersIn: " ,)")) {
            alergens.insert(alergen)
            _ = scanner.scanString(",")
        }
    }
}

public struct FoodList {
    var foods: [Food]

    var allAlergens: Set<String> {
        foods.map(\.alergens).unionAll()
    }

    var allIngredients: Set<String> {
        foods.map(\.ingredients).unionAll()
    }

    func ingredientsMayContain(alergen: String) -> Set<String> {
        foods
            .filter { food in food.alergens.contains(alergen) }
            .map(\.ingredients).reduce { $0.intersection($1) } ?? []
    }

    public func knownSafeIngredients() -> Set<String> {
        var ingredients = self.allIngredients
        for alergen in allAlergens {
            ingredients.subtract(ingredientsMayContain(alergen: alergen))
        }
        return ingredients
    }

    public func countSafeIngredients() -> Int {
        let safe = knownSafeIngredients()
        return foods.map { food in
            food.ingredients.intersection(safe).count
        }.sum()
    }

    struct Ingredient : Hashable {
        var name: String
        var alergen: String
    }

    func dangerousIngredients() -> Set<Ingredient> {
        var possible = allAlergens
            .map { (alergen: $0, ingredients: ingredientsMayContain(alergen: $0)) }
        var dangerous = Set<Ingredient>()
        while !possible.isEmpty {
            // There is only one possibility with 1 ingredient
            let known = possible.first { $0.ingredients.count == 1 }!
            let knownIngredient = known.ingredients.first!
            // Add it to the list
            dangerous.insert(.init(name: knownIngredient, alergen: known.alergen))
            // Remove ingredient from remaining possibile options
            for i in possible.indices {
                possible[i].ingredients.subtract([knownIngredient])
            }
            // Remove elements that no longer have options
            possible.removeAll { $0.ingredients.isEmpty }
        }
        return dangerous
    }

    public func canonicalDangerousIngredients() -> String {
        dangerousIngredients().sorted(on: \.alergen).map(\.name).commaSeparated()
    }
}

public extension FoodList {
    init(_ description: String) {
        foods = description.lines().map(Food.init)
    }
}

fileprivate let input = Bundle.module.text(named: "day21")

public func day21_1() -> Int {
    FoodList(input).countSafeIngredients()
}

public func day21_2() -> String {
    FoodList(input).canonicalDangerousIngredients()
}
