//
//  GCD.swift
//
//
//  Created by John Griffin on 10/5/19.
//

import Foundation

// return Greatest common devisor using the  Euclidean Algorithm
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
