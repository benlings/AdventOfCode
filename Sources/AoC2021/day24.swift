import Foundation
import AdventCore
import DequeModule

enum Variable : Character {
    case w = "w", x = "x", y = "y", z = "z"
}

enum Value {
    case literal(Int)
    case variable(Variable)
}

extension Value : CustomStringConvertible {
    var description: String {
        switch self {
        case .variable(let v): return v.rawValue.description
        case .literal(let i): return i.description
        }
    }
}

enum BinaryOperation : String {
    case add
    case mul
    case div
    case mod
    case eql
}

enum Instruction {
    case inp(a: Variable)
    case binary(op: BinaryOperation, a: Variable, b: Value)

    //inp a - Read an input value and write it to variable a.
    //add a b - Add the value of a to the value of b, then store the result in variable a.
    //mul a b - Multiply the value of a by the value of b, then store the result in variable a.
    //div a b - Divide the value of a by the value of b, truncate the result to an integer, then store the result in variable a. (Here, "truncate" means to round the value toward zero.)
    //mod a b - Divide the value of a by the value of b, then store the remainder in variable a. (This is also called the modulo operation.)
    //eql a b - If the value of a and b are equal, then store the value 1 in variable a. Otherwise, store the value 0 in variable a.

    func execute(input: inout [Int], variables: inout [Variable : Int]) {
        switch self {
        case let .inp(a: variable):
            variables[variable] = input.removeFirst()
        case let .binary(op: op, a: a, b: b):
            var result: Int
            let lhs = variables[a]!
            let rhs: Int
            switch b {
            case let .literal(l): rhs = l
            case let .variable(v): rhs = variables[v]!
            }
            switch op {
            case .add: result = lhs + rhs
            case .mul: result = lhs * rhs
            case .div: result = lhs / rhs
            case .mod: result = lhs % rhs
            case .eql: result = lhs == rhs ? 1 : 0
            }
            variables[a] = result
        }
    }
}

extension Instruction {
    init?(_ description: String) {
        if let i = Scanner(string: description).scanInstruction() {
            self = i
        } else {
            return nil
        }
    }
}

extension Instruction : CustomStringConvertible {
    var description: String {
        switch self {
        case .inp(a: let v): return "inp \(v.rawValue)"
        case let .binary(op: op, a: a, b: b):
            return "\(op) \(a) \(b)"
        }
    }
}

public struct ArithmeticLogicUnit {

    var instructions: Deque<Instruction>

    var variables: [Variable : Int] = [
        .w : 0,
        .x : 0,
        .y : 0,
        .z : 0,
    ]

    public var variableValues: [Int] {
        variables.sorted(on: \.key.rawValue).map(\.value)
    }

    public mutating func run(input: inout [Int]) {
        var line = 1
        while let i = instructions.popFirst() {
            i.execute(input: &input, variables: &variables)
            print("\(line): \(i) - w:\(variables[.w]!) x:\(variables[.x]!) y:\(variables[.y]!) z:\(variables[.z]!)")
            line += 1
        }
    }

    public func valid(input: Int) -> Int {
        var inputDigits = input.description.compactMap { $0.wholeNumberValue }
        var copy = self
        copy.run(input: &inputDigits)
        return copy.variables[.z]!
    }

}

extension ArithmeticLogicUnit {
    public init(_ description: String) {
        self.instructions = Deque(description.lines().compactMap(Instruction.init))
    }
}

fileprivate extension Scanner {
    func scanInstruction() -> Instruction? {
        guard let name = scanUpToCharacters(from: .whitespaces) else { return nil }
        switch name {
        case "inp":
            return scanVariable().map { .inp(a: $0) }
        default:
            guard let op = BinaryOperation(rawValue: name),
                  let a = scanVariable(),
                  let b = scanValue()
            else { return nil }
            return .binary(op: op, a: a, b: b)
        }
    }

    func scanVariable() -> Variable? {
        scanCharacter().flatMap { Variable(rawValue: $0) }
    }

    func scanValue() -> Value? {
        if let literal = scanInt() {
            return .literal(literal)
        } else if let variable = scanVariable() {
            return .variable(variable)
        } else {
            return nil
        }
    }
}

fileprivate let day24_input = Bundle.module.text(named: "day24")

extension ArithmeticLogicUnit {
    public static let monad = ArithmeticLogicUnit(day24_input)
}

public func day24_1() -> Int {
    let alu = ArithmeticLogicUnit.monad
    let number = 41299994879959
    assert(alu.valid(input: number) == 0)
    return number
}

public func day24_2() -> Int {
    let alu = ArithmeticLogicUnit.monad
    let number = 11189561113216
    assert(alu.valid(input: number) == 0)
    return number
}

/*
  inp w     inp w     inp w    inp w    inp w    inp w    inp w    inp w     inp w    inp w    inp w    inp w     inp w    inp w
  mul x 0   mul x 0   mul x 0  mul x 0  mul x 0  mul x 0  mul x 0  mul x 0   mul x 0  mul x 0  mul x 0  mul x 0   mul x 0  mul x 0
  add x z   add x z   add x z  add x z  add x z  add x z  add x z  add x z   add x z  add x z  add x z  add x z   add x z  add x z
  mod x 26  mod x 26  mod x 26 mod x 26 mod x 26 mod x 26 mod x 26 mod x 26  mod x 26 mod x 26 mod x 26 mod x 26  mod x 26 mod x 26
a div z 1   div z 1   div z 1  div z 26 div z 26 div z 1  div z 1  div z 26  div z 1  div z 1  div z 26 div z 26  div z 26 div z 26
b add x 11  add x 12  add x 13 add x -5 add x -3 add x 14 add x 15 add x -16 add x 14 add x 15 add x -7 add x -11 add x -6 add x -11
  eql x w   eql x w   eql x w  eql x w  eql x w  eql x w  eql x w  eql x w   eql x w  eql x w  eql x w  eql x w   eql x w  eql x w
  eql x 0   eql x 0   eql x 0  eql x 0  eql x 0  eql x 0  eql x 0  eql x 0   eql x 0  eql x 0  eql x 0  eql x 0   eql x 0  eql x 0
  mul y 0   mul y 0   mul y 0  mul y 0  mul y 0  mul y 0  mul y 0  mul y 0   mul y 0  mul y 0  mul y 0  mul y 0   mul y 0  mul y 0
  add y 25  add y 25  add y 25 add y 25 add y 25 add y 25 add y 25 add y 25  add y 25 add y 25 add y 25 add y 25  add y 25 add y 25
  mul y x   mul y x   mul y x  mul y x  mul y x  mul y x  mul y x  mul y x   mul y x  mul y x  mul y x  mul y x   mul y x  mul y x
  add y 1   add y 1   add y 1  add y 1  add y 1  add y 1  add y 1  add y 1   add y 1  add y 1  add y 1  add y 1   add y 1  add y 1
  mul z y   mul z y   mul z y  mul z y  mul z y  mul z y  mul z y  mul z y   mul z y  mul z y  mul z y  mul z y   mul z y  mul z y
  mul y 0   mul y 0   mul y 0  mul y 0  mul y 0  mul y 0  mul y 0  mul y 0   mul y 0  mul y 0  mul y 0  mul y 0   mul y 0  mul y 0
  add y w   add y w   add y w  add y w  add y w  add y w  add y w  add y w   add y w  add y w  add y w  add y w   add y w  add y w
c add y 16  add y 11  add y 12 add y 12 add y 12 add y 2  add y 11 add y 4   add y 12 add y 9  add y 10 add y 11  add y 6  add y 15
  mul y x   mul y x   mul y x  mul y x  mul y x  mul y x  mul y x  mul y x   mul y x  mul y x  mul y x  mul y x   mul y x  mul y x
  add z y   add z y   add z y  add z y  add z y  add z y  add z y  add z y   add z y  add z y  add z y  add z y   add z y  add z y

  18        36        54       72       90       108      126      144       162      180      198      216       234      252


 solutions
 ---------
 i 4  1  2  9  9  9  9    4  8 7  9    9  5   9  (largest)
 i 1  1  1  8  9  5  6    1  1 1  3    2  1   6 (smallest)

   1  2  3  4  5  6  7    8  9 10 11  12 13  14
 -----------------------------------------------
 a 1  1  1  /  /  1  1   /   1  1  /   /   /  /
 b 11 12 14 -5 -3 14 15 -16 14 15 -7 -11 -6 -11
 c 16 11 12 12 12  2 11   4 12  9 10  11  6  15

 Simplified code
 ---------------
 w = inp
 x = z % 26 + b = last addition (ie. last time x != w) + b
 z /= a
 if x != w {
   z *= 26
   z += w + c
 }

 z at each step
 --------------
 z1 = i1 + 16
 z2 = z1 * 26 + i2 + 11
 z3 = z2 * 26 + i3 + 12
 z4 = z2 (i4 + 5 == i3 + 12; i4 - i3 == 7)
 z5 = z1 (i5 + 3 == i2 + 11; i5 - i2 == 8)
 z6 = z1 * 26 + i6 + 2
 z7 = z6 * 26 + i7 + 11
 z8 = z6 (i8 + 16 == i7 + 11; i8 - i7 == -5)
 z9 = z6 * 26 + i9 + 12
 z10 = z9 * 26 + i10 + 9
 z11 = z9 (i11 + 7 == i10 + 9; i11 - i10 == 2)
 z12 = z6 (i12 + 11 == i9 + 12; i12 - i9 == 1)
 z13 = z1 (i13 + 6 == i6 + 2; i13 - i6 == -4)
 z14 = 0 (i14 + 11 == i1 + 16; i14 - i1 == 5)

 */
