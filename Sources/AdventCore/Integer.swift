//
//  File.swift
//  
//
//  Created by Ben Lings on 19/12/2020.
//

import Foundation
import Algorithms

public extension BinaryInteger {

    subscript(bit bit: Int) -> Bool {
        get {
            let setBit: Self = 0b1 << bit
            return self & setBit == setBit
        }
        set {
            let setBit: Self = 0b1 << bit
            if newValue {
                self |= setBit
            } else {
                self &= ~setBit
            }
        }
    }

    func setting(bit: Int, value: Bool) -> Self {
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

public extension Array where Element : BinaryInteger {
    func lcm() -> Element? {
        reduce(Element.lcm)
    }
}
