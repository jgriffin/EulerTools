//
//  FactorsTests.swift
//
//
//  Created by John Griffin on 1/12/20.
//

import EulerTools
import XCTest

class FactorsTests: XCTestCase {
    func testPrimeFactors() {
        let check: [[UInt]] = [
            [],
            [], [2], [3], [2], [5],
            [2, 3], [7], [2], [3], [2, 5],
            [11], [2, 3], [13], [2, 7], [3, 5],
            [2], [17], [2, 3], [19], [2, 5],
            [3, 7],
        ]

        let primes = Primes.primesUpto(100)[...]
        let result = (UInt(0) ... 21).map { Factors.uint.primeFactors(of: $0, from: primes) }
        XCTAssertEqual(result, check)
    }

    func testDivisors() {
        let check: [[UInt]] = [
            [],
            [], [], [], [2], [],
            [2, 3], [], [2, 4], [3], [2, 5],
            [], [2, 3, 4, 6], [], [2, 7], [3, 5],
            [2, 4, 8], [], [2, 3, 6, 9], [], [2, 4, 5, 10],
            [3, 7],
        ]

        let result = (0 ... 21).map { Factors.uint.divisors(of: $0) }
        XCTAssertEqual(result, check)
    }
}
