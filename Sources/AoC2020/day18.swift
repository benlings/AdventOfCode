import Foundation
import AdventCore

extension Scanner {

    func peekString(_ s: String) -> Bool {
        let i = currentIndex
        defer { currentIndex = i }
        return scanString(s) != nil
    }

    // expr   = factor { ("*"|"+") factor }
    // factor = int | "(" expr ")"

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

    // expr   = term { "*" term }
    // term   = factor { "+" factor }
    // factor = int | "(" expr ")"

    func scanExpr2() -> Int? {
        guard var result = scanTerm2() else {
            return nil
        }

        while !peekString(")") && !isAtEnd {
            let pos = currentIndex
            if let _ = scanString("*"),
               let rhs = scanTerm2() {
                result *= rhs
            } else {
                currentIndex = pos
                return result
            }
        }
        return result
    }

    func scanTerm2() -> Int? {
        guard var result = scanFactor2() else {
            return nil
        }
        while !peekString(")") && !isAtEnd {
            let pos = currentIndex
            if let _ = scanString("+"),
               let rhs = scanFactor2() {
                result += rhs
            } else {
                currentIndex = pos
                return result
            }
        }
        return result
    }

    func scanFactor2() -> Int? {
        if let n = scanInt() {
            return n
        }
        if let _ = scanString("("),
           let n = scanExpr2(),
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

public func evalExpr2(_ input: String) -> Int {
    let scanner = Scanner(string: input)
    return scanner.scanExpr2()!
}

fileprivate let input = Bundle.module.text(named: "day18")

public func day18_1() -> Int {
    input.lines().map(evalExpr).sum()
}

public func day18_2() -> Int {
    input.lines().map(evalExpr2).sum()
}
