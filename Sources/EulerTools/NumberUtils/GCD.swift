//
//  GCD.swift
//
//
//  Created by John Griffin on 10/5/19.
//

import Foundation

// return Greatest common divisor using the  Euclidean Algorithm
public func GCD<T: SignedInteger>(_ a: T, _ b: T) -> T {
    if a == 0 { return b }
    if b == 0 { return a }
    if a < 0 || b < 0 {
        // negative numbers still have positive GCDs but is screws up modulo below
        return GCD(abs(a), abs(b))
    }

    // a = b * q + r
    let r = a % b
    return GCD(b, r)
}

public func GCD<T: SignedInteger>(_ a: [T]) -> T { a.reduce(1, GCD) }
public func GCD<T: SignedInteger>(_ a: T...) -> T { GCD(a) }

/// Least common multiple
/// lcm (a,b)=  |ab| / gcd(a,b)
public func LCM<T: SignedInteger>(_ a: T, _ b: T) -> T {
    abs(a * b) / GCD(a, b)
}

public func LCM<T: SignedInteger>(_ a: [T]) -> T { a.reduce(1, LCM) }
public func LCM<T: SignedInteger>(_ a: T...) -> T { LCM(a) }

public extension SignedInteger {
    // extendedGCD
    // solving ax + by = gcd(a,b)
    //
    static func extendedGCD(_ a: Self, _ b: Self) -> (gcd: Self, x: Self, y: Self) {
        var (old_r, r) = (a, b)
        var (old_s, s) = (1 as Self, 0 as Self)
        var (old_t, t) = (0 as Self, 1 as Self)

        while r != 0 {
            let quotient = old_r / r
            (old_r, r) = (r, old_r - quotient * r)
            (old_s, s) = (s, old_s - quotient * s)
            (old_t, t) = (t, old_t - quotient * t)
        }

        return (gcd: old_r, x: old_s, y: old_t)
    }

    // modularMultiplicativeInverse
    // solving a⋅x ≡ 1 mod m
    // or a⋅x + m⋅y = 1
    // or ay ≡ 1 mod n
    //
    static func modularMultiplicativeInverse(_ a: Self, _ m: Self) -> Self? {
        let egcd = extendedGCD(a, m)
        guard egcd.gcd == 1 else { return nil }

        // make it positive
        return (egcd.x + m) % m
    }

    static func chineseRemainderTheorem(_ amis: [(ai: Self, mi: Self)]) -> Self? {
        let ais = amis.map(\.ai)
        let mis = amis.map(\.mi)
        let M = mis.reduce(1, *)

        let bis = mis.map { M / $0 }
        let biinvs = zip(bis, mis).map { bi, mi in modularMultiplicativeInverse(bi, mi)! }

        let aibibiinvs = zip(ais, zip(bis, biinvs)).map { ($0, $1.0, $1.1) }
        let xis = aibibiinvs
            .map { $0 * $1 * $2 }
        let x = xis.reduce(0, +) % M

        return x
    }
}
