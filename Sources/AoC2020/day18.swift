import Foundation
import AdventCore

public indirect enum Expr {
    case number(Int)
    case operation(Expr, Expr, (Int, Int) -> Int)

    public func eval() -> Int {
        switch self {
        case .number(let n): return n
        case .operation(let lhs, let rhs, let op): return op(lhs.eval(), rhs.eval())
        }
    }
}

fileprivate extension Scanner {

    func peekString(_ s: String) -> Bool {
        let i = currentIndex
        defer { currentIndex = i }
        return scanString(s) != nil
    }

    // expr   = factor { ("*"|"+") factor }
    // factor = int | "(" expr ")"

    func scanExpr() -> Expr? {
        guard var result = scanFactor() else { return nil }
        
        // Left associative - consume these in a loop
        while peekString("*") || peekString("+") {
            if let _ = scanString("*"),
               let rhs = scanFactor() {
                result = .operation(result, rhs, *)
            } else if let _ = scanString("+"),
                      let rhs = scanFactor() {
                result = .operation(result, rhs, +)
            }
        }
        return result
    }

    func scanFactor() -> Expr? {
        if let n = scanInt() {
            return .number(n)
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

    func scanExpr2() -> Expr? {
        guard var result = scanTerm2() else { return nil }
        // Left associative - consume in a loop
        while scanString("*") != nil {
            guard let rhs = scanTerm2() else { return nil }
            result = .operation(result, rhs, *)
        }
        return result
    }

    func scanTerm2() -> Expr? {
        guard var result = scanFactor2() else { return nil }
        // Left associative - consume in a loop
        while scanString("+") != nil {
            guard let rhs = scanFactor2() else { return nil }
            result = .operation(result, rhs, +)
        }
        return result
    }

    func scanFactor2() -> Expr? {
        if let n = scanInt() {
            return .number(n)
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
    return Expr(input).eval()
}

public func evalExpr2(_ input: String) -> Int {
    return Expr(input, v2: true).eval()
}

public extension Expr {
    init(_ description: String, v2: Bool = false) {
        let scanner = Scanner(string: description)
        if v2 {
            self = scanner.scanExpr2()!
        } else {
            self = scanner.scanExpr()!
        }
    }
}

fileprivate let input = Bundle.module.text(named: "day18")

public func day18_1() -> Int {
    input.lines().map(evalExpr).sum()
}

public func day18_2() -> Int {
    input.lines().map(evalExpr2).sum()
}
