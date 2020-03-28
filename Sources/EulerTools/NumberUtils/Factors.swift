//
//  Factors.swift
//
//
//  Created by John Griffin on 10/1/19.
//

import Foundation

public class Factors {
    public static var int = FixedWidthFactors<Int>()
    public static var uint = FixedWidthFactors<UInt>()
}

public class FixedWidthFactors<I: FixedWidthInteger> {
    private let divisorsMemoizer = Memoizer<I, [I]>()

    // non-trivial divisors of n
    public func divisors(of n: I) -> [I] {
        if n == 0 || n == 1 {
            return []
        }
        return divisorsMemoizer.memoized(n) {
            let halfn = n / 2
            guard halfn >= 2 else {
                return []
            }
            let factors = (2 ... halfn).filter { n % $0 == 0 }
            return factors
        }
    }

    private let primeFactorMemoizer = Memoizer<I, [I]>()

    // prime factors excludes the number itself if it is prime
    public func primeFactors<A: RandomAccessCollection>(of n: I, from primes: A) -> [I]
        where A.Element == I {
        if n == 0 || n == 1 {
            return []
        }

        return primeFactorMemoizer.memoized(n) {
            guard let indexN = primes.binarySearch(indexFor: n) else {
                fatalError()
            }
            if primes[indexN] == n {
                // n is prime
                return [n]
            }

            let primeSlice = primes[...indexN]
            let sqrtN = I(sqrt(Float(n)))
            let iSqrtN = primeSlice.binarySearch(indexFor: sqrtN)!

            for p in primeSlice[...iSqrtN].reversed() {
                guard n % p == 0 else {
                    continue
                }

                var remain = n
                repeat {
                    remain /= p
                } while remain % p == 0

                return primeFactors(of: remain, from: primeSlice) + [p]
            }

            fatalError("Shouldn't get here")
        }
    }
}
