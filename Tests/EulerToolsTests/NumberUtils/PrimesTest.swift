//
//  PrimesTest.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/12/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import EulerTools
import XCTest

class PrimesTests: XCTestCase {
//    https://primes.utm.edu/howmany.html
    let primeCountsCheck: [UInt: UInt] = [
        10: 4,
        100: 25,
        1000: 168,
        10000: 1229,
        100_000: 9592,
        1_000_000: 78498,
        10_000_000: 664_579,
        100_000_000: 5_761_455,
        1_000_000_000: 50_847_534,
        10_000_000_000: 455_052_511,
        100_000_000_000: 4_118_054_813,
        1_000_000_000_000: 37_607_912_018,
        10_000_000_000_000: 346_065_536_839,
        100_000_000_000_000: 3_204_941_750_802,
    ]

    private func checkPrimesUpto(_ nMax: UInt) {
        var primeCount: UInt = 0
        for n: UInt in 2 ... nMax {
            if try! Primes.checkWithMillerRabin(n) {
                primeCount += 1
            }

            if n % 10000 == 0 {
                if let check = primeCountsCheck[UInt(n)] {
                    print("checking prime count under \(n)\t \(primeCount) == \(check)")
                    XCTAssertEqual(primeCount, check)
                }
            }
        }
    }

    func testPrimesUnderOneMillion() {
        checkPrimesUpto(1_000_000)
    }

    func testPrimeupToOneMillion() {
        let primes = Primes.primesUpto(1_000_000)
        XCTAssertEqual(primes.count, 78498)
    }

    func slowtestPrimesUnderOneBillion() {
        checkPrimesUpto(1_000_000_000)
    }

    func testBiggestCheckWithMillerRabinUInt() {
        // binary search for first n that throws in Primes.checkWithMillerRabin
        var (lower, upper) = (UInt(2), UInt(100_000_000_000 + 1))
        while lower < upper {
            let middle = lower + (upper - lower) / 2

            do {
                _ = try Primes.checkWithMillerRabin(middle)

                lower = middle + 1
            } catch {
                upper = middle
            }
        }

        // first failing
        XCTAssertEqual(lower, 50_071_503_041)
        XCTAssertThrowsError(try Primes.checkWithMillerRabin(lower))

        let biggest = lower - 1
        XCTAssertEqual(biggest, 50_071_503_040)
        XCTAssertNoThrow(try! Primes.isPrime(biggest))
    }
}
