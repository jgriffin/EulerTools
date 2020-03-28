//
//  FractionTests.swift
//
//
//  Created by John Griffin on 10/26/19.
//

import EulerTools
import XCTest

class FractionTests: XCTestCase {
    typealias Frac = Fraction<Int>

    func testFromInteger() {
        let tests: [(int: Int, check: Frac)] = [
            (1, Frac(1, 1)),
            (2, Frac(2, 1)),
        ]

        tests.forEach { test in
            let result = Fraction(test.int)
            XCTAssertEqual(result, test.check)
        }
    }

    func testAddingIntegers() {
        let tests: [(lhs: Frac, rhs: Frac, check: Frac)] = [
            (Frac(1, 1), Frac(1, 1), Frac(2, 1)),
            (Frac(1, 2), Frac(1, 2), Frac(2, 2)),
            (Frac(1, 2), Frac(1, 3), Frac(5, 6)),
            (Frac(1, 2), Frac(1, 6), Frac(4, 6)),
            (Frac(1, 6), Frac(1, 12), Frac(3, 12)),
        ]

        tests.forEach { test in
            let result = test.lhs + test.rhs
            XCTAssertEqual(result, test.check)
        }
    }
}
