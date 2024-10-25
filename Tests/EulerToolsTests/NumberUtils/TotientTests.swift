//
//  TotientTests.swift
//
//
//  Created by John Griffin on 1/12/20.
//

import EulerTools
import XCTest

class TotientTests: XCTestCase {
    let primesUpTo200 = Primes.primesUpto(200)[...]

    func testTotient2() async {
        let result = await Totient.totient(2, primes: primesUpTo200)
        XCTAssertEqual(result, 1)
    }

    func testTotient3() async {
        let result = await Totient.totient(3, primes: primesUpTo200)
        XCTAssertEqual(result, 2)
    }

    func testTotient1000000() async {
        let n: UInt = 1_000_000
        let primes = Primes.primesPast(n)[...]
        let result = await Totient.totient(n, primes: primes)
        XCTAssertEqual(result, result)
    }

    func testTotients() async {
        let tests: [(test: UInt, check: UInt)] = [
            (1, 1), (2, 1), (3, 2), (4, 2), (5, 4), (6, 2), (7, 6), (8, 4), (9, 6), (10, 4),
            (60, 16), (132, 40),
        ]

        for test in tests {
            let result = await Totient.totient(test.test, primes: primesUpTo200)
            XCTAssertEqual(result, test.check, "i: \(test.test)")
        }
    }
}
