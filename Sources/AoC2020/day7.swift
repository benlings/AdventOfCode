import Foundation
import AdventCore

public struct LuggageBag : Hashable, Equatable {
    var bagDescription: String
}

public struct LuggageRule : Equatable {
    var bag: LuggageBag
    var contents = Set<LuggageBag>() // FIXME add count
}

extension Scanner {
    func scanLuggageBag() -> LuggageBag? {
        guard let description1 = scanUpToCharacters(from: .whitespaces),
              let description2 = scanUpToCharacters(from: .whitespaces),
              scanString("bags") ?? scanString("bag") != nil else {
            return nil
        }
        return LuggageBag(bagDescription: "\(description1) \(description2)")
    }
}

public extension LuggageRule {
    init?(_ ruleDescription: String) {
        let scanner = Scanner(string: ruleDescription)
        self.bag = scanner.scanLuggageBag()!
        _ = scanner.scanString("contain")
        _ = scanner.scanInt() // Count
        contents.insert(scanner.scanLuggageBag()!)
        _ = scanner.scanString(",")
        _ = scanner.scanInt() // Count
        contents.insert(scanner.scanLuggageBag()!)
        _ = scanner.scanString(".")
    }
}
