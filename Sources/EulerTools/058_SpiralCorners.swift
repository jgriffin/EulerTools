//
//  058_SpiralPrimes.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/11/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

// Starting with 1 and spiralling anticlockwise in the following way, a square spiral with side length 7 is formed.
//
// 37 36 35 34 33 32 31
// 38 17 16 15 14 13 30
// 39 18  5  4  3 12 29
// 40 19  6  1  2 11 28
// 41 20  7  8  9 10 27
// 42 21 22 23 24 25 26
// 43 44 45 46 47 48 49
//
// It is interesting to note that the odd squares lie along the bottom right diagonal, but what is more interesting is that 8 out of the 13 numbers lying along both diagonals are prime; that is, a ratio of 8/13 ≈ 62%.
//
// If one complete new layer is wrapped around the spiral above, a square spiral with side length 9 will be formed. If this process is continued, what is the side length of the square spiral for which the ratio of primes along both diagonals first falls below 10%?

public struct SpiralCorners: IteratorProtocol, Sequence {
    var ring: UInt = 0 {
        didSet {
            cornerInc = Self.sideLengthForRing(ring) - 1
            ringMax = Self.maxForRing(ring)
        }
    }

    var cornerInc: UInt = 1
    var ringMax: UInt = 1

    var current: UInt = 0

    public mutating func next() -> UInt? {
        if ringMax <= current {
            ring += 1
        }

        current += cornerInc
        return current
    }

    // MARK: helpers

    public static func sideLengthForRing(_ ring: UInt) -> UInt {
        return 2 * ring + 1
    }

    public static func maxForRing(_ ring: UInt) -> UInt {
        return (2 * ring + 1) * (2 * ring + 1)
    }

    public static func cornersUpToRing(_ ring: UInt) -> AnySequence<UInt> {
        let max = Self.maxForRing(ring)
        let corners = SpiralCorners()
        return AnySequence(corners.lazy.prefix(while: { $0 <= max }))
    }
}

struct PrimeCounter {
    var counter = Counter()

    mutating func countIfPrime(_ n: UInt) {
        counter.count(try! Primes.isPrime(n))
    }

    mutating func countPrimes(in sequence: AnySequence<UInt>) {
        sequence.forEach { n in
            countIfPrime(n)
        }
    }

    var primeRatio: Float { counter.trueRatio }
}

func solveSpiralPrimes58() {
    var primeCounter = Counter()

    for (i, c) in SpiralCorners().enumerated() {
        primeCounter.count(try! Primes.isPrime(c))
        if primeCounter.trueRatio < 0.1 {
            print("i: \(i) ratio: \(primeCounter.trueRatio)")
            break
        }
    }
}
