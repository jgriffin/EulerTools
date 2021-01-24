//
//  BigFraction.swift
//
//
//  Created by John Griffin on 10/26/19.
//

import Foundation

public typealias Fraction = Fractional<Int>

public struct Fractional<T: SignedInteger>:
    Equatable, ExpressibleByIntegerLiteral, CustomStringConvertible, CustomDebugStringConvertible
{
    public typealias Component = T
    public typealias IntegerLiteralType = Int

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

    public init(_ num: T, _ den: T = 1) {
        self.init(num: num, den: den)
    }

    public init(integerLiteral: Self.IntegerLiteralType) {
        self.init(num: Component(integerLiteral))
    }

    public var description: String { "(\(num)/\(den))" }
    public var debugDescription: String { "(\(num)/\(den))" }
}

public extension Fractional {
    var reciprocal: Fractional {
        Fractional(num: den, den: num)
    }

    var reduced: Fractional {
        let divisor = GCD(num, den)
        return Fractional(num / divisor, den / divisor)
    }

    var isReduced: Bool {
        abs(GCD(num, den)) == 1
    }

    var negate: Fractional {
        Fractional(num: -num, den: den)
    }
}

public extension Fractional {
    static func + (_ lhs: Fractional, _ rhs: Fractional) -> Fractional {
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

    static prefix func - (_ f: Fractional) -> Fractional { f.negate }

    static func - (_ lhs: Fractional, _ rhs: Fractional) -> Fractional {
        lhs + rhs.negate
    }

    static func * (lhs: Fractional, rhs: Fractional) -> Fractional {
        Fractional(num: lhs.num * rhs.num,
                   den: lhs.den * rhs.den)
    }

    static func / (lhs: Fractional, rhs: Fractional) -> Fractional {
        lhs * rhs.reciprocal
    }
}

extension Fractional {
    var isValid: Bool {
        guard den > 0 else { return false }

        return true
    }
}
