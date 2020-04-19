//
//  BigFraction.swift
//
//
//  Created by John Griffin on 10/26/19.
//

import Foundation

public typealias Fraction = Fractional<Int>

public struct Fractional<T: SignedInteger>: Equatable, CustomStringConvertible, CustomDebugStringConvertible {
    public typealias Component = T
    public let num: T
    public let den: T

    public init(num: T, den: T = 1) {
        if den > 0 {
            self.num = num
            self.den = den
        } else {
            self.num = -num
            self.den = -den
        }

        assert(isValid)
    }

    public var description: String { return "(\(num)/\(den))" }
    public var debugDescription: String { return "(\(num)/\(den))" }
}

extension Fractional {
    public init(_ num: T, _ den: T = 1) {
        self.init(num: num, den: den)
    }

    public var reciprocal: Fractional {
        return Fractional(num: den, den: num)
    }

    public var reduced: Fractional {
        let divisor = GCD(num, den)
        return Fractional(num / divisor, den / divisor)
    }

    public var isReduced: Bool {
        return abs(GCD(num, den)) == 1
    }

    public var negate: Fractional {
        return Fractional(num: -num, den: den)
    }
}

extension Fractional {
    public static func + (_ lhs: Fractional, _ rhs: Fractional) -> Fractional {
        if lhs.num == 0 {
            return rhs
        }
        if rhs.num == 0 {
            return lhs
        }

        if lhs.den == rhs.den {
            return Fractional(num: lhs.num + rhs.num, den: lhs.den)
        }

        let denGCD = GCD(lhs.den, rhs.den)
        let denLCM = (lhs.den * rhs.den) / denGCD
        let leftNum = lhs.num * (denLCM / lhs.den)
        let rightNum = rhs.num * (denLCM / rhs.den)

        return Fractional(num: leftNum + rightNum, den: denLCM)
    }

    public static prefix func - (_ f: Fractional) -> Fractional { f.negate }

    public static func - (_ lhs: Fractional, _ rhs: Fractional) -> Fractional {
        return lhs + rhs.negate
    }

    public static func * (lhs: Fractional, rhs: Fractional) -> Fractional {
        return Fractional(num: lhs.num * rhs.num,
                          den: lhs.den * rhs.den)
    }
}

extension Fractional {
    var isValid: Bool {
        guard den > 0 else { return false }

        return true
    }
}
