//
//  File.swift
//  
//
//  Created by Ben Lings on 19/12/2020.
//

import Foundation
import Algorithms

public extension BinaryInteger {

    subscript(bit bit: Int) -> Bit {
        get {
            let setBit: Self = 0b1 << bit
            return Bit(self & setBit == setBit)
        }
        set {
            let setBit: Self = 0b1 << bit
            if Bool(newValue) {
                self |= setBit
            } else {
                self &= ~setBit
            }
        }
    }

    func reversed(size: Int) -> Self {
        precondition(size < bitWidth)
        var r = 0 as Self
        for bit in 0..<size {
            r[bit: size - bit - 1] = self[bit: bit]
        }
        return r
    }

    func setting(bit: Int, value: Bit) -> Self {
        var r = self
        r[bit: bit] = value
        return r
    }

    func bitPermutations(mask: Self) -> AnySequence<Self> {
        if mask == 0 {
            return AnySequence([self])
        } else {
            let setBit: Self = 0b1 << mask.trailingZeroBitCount
            return AnySequence(chain((self | setBit).bitPermutations(mask: mask & ~setBit),
                                     (self & ~setBit).bitPermutations(mask: mask & ~setBit)))
        }
    }

    static func gcd(_ m: Self, _ n: Self) -> Self {
        let r = m % n
        if r != 0 {
            return gcd(n, r)
        } else {
            return n
        }
    }

    static func lcm(_ m: Self, _ n: Self) -> Self {
        m / gcd(m, n) * n
    }
}

public extension FixedWidthInteger {

    init(bits: some Sequence<Bool>) {
        self = Self.init(bits.map { $0 ? "1" : "0" }.joined(), radix: 2)!
    }

}

public extension Array where Element : BinaryInteger {
    func lcm() -> Element? {
        reduce(Element.lcm)
    }
}
