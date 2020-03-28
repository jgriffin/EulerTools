//
//  BigFraction.swift
//
//
//  Created by John Griffin on 10/26/19.
//

import Foundation

public struct Fraction<T: SignedInteger>: Equatable, CustomStringConvertible, CustomDebugStringConvertible {
    public typealias Component = T
    public let num: T
    public let den: T

    public var description: String { return "(\(num)/\(den))" }
    public var debugDescription: String { return "(\(num)/\(den))" }
}

extension Fraction {
    public init(_ num: Self.Component, _ den: Self.Component = 1) {
        self.init(num: num, den: den)
    }

    public static func + (_ left: Fraction, _ right: Fraction) -> Fraction {
        if left.den == right.den {
            return Fraction(num: left.num + right.num, den: left.den)
        }

        let denGCD = GCD(left.den, right.den)
        let denLCM = (left.den * right.den) / denGCD
        let leftNum = left.num * (denLCM / left.den)
        let rightNum = right.num * (denLCM / right.den)

        return Fraction(num: leftNum + rightNum, den: denLCM)
    }
}
