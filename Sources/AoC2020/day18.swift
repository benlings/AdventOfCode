import Foundation
import AdventCore

extension Scanner {

    func peekString(_ s: String) -> Bool {
        let i = currentIndex
        defer { currentIndex = i }
        return scanString(s) != nil
    }

    func scanExpr() -> Int? {
        guard var result = scanFactor() else {
            return nil
        }
        
        while !peekString(")") && !isAtEnd {
            if let _ = scanString("*"),
               let rhs = scanFactor() {
                result *= rhs
            } else if let _ = scanString("+"),
                      let rhs = scanFactor() {
                result += rhs
            }
        }
        return result
    }

    func scanFactor() -> Int? {
        if let n = scanInt() {
            return n
        }
        if let _ = scanString("("),
           let n = scanExpr(),
           let _ = scanString(")") {
            return n
        }
        return nil
    }

}

public func evalExpr(_ input: String) -> Int {
    let scanner = Scanner(string: input)
    return scanner.scanExpr()!
}

fileprivate let input = Bundle.module.text(named: "day18")

public func day18_1() -> Int {
    input.lines().map(evalExpr).sum()
}

public func day18_2() -> Int {
    0
}
