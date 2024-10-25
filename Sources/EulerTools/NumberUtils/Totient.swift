//
//  Totient.swift
//
//
//  Created by John Griffin on 1/12/20.
//

import Foundation

public enum Totient {
    public static func totient(_ n: UInt, primes: ArraySlice<UInt>) async -> UInt {
        let primeFactors = await Factors.uint.primeFactors(of: n, from: primes)
        let result = primeFactors
            .reduce(n) { result, p in
                result - result / p
            }
        return result
    }
}
