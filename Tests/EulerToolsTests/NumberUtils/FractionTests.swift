//
//  FractionTests.swift
//
//
//  Created by John Griffin on 10/26/19.
//

import EulerTools
import XCTest

class FractionTests: XCTestCase {
    typealias Frac = Fraction

    // MARK: initializers

    func testFromIntegers() {
        let tests: [(num: Int, den: Int, check: Frac)] = [
            (1, 1, Frac(1, 1)),
            (2, 1, Frac(2, 1)),
            (1, 2, Frac(1, 2)),
            (-1, 2, Frac(-1, 2)),
            (-1, 2, Frac(-1, 2)),
            (1, -2, Frac(-1, 2)),
            (-1, -2, Frac(1, 2)),
        ]

        tests.forEach { test in
            let result = Fraction(test.num, test.den)
            XCTAssertEqual(result, test.check)
        }
    }

    func testFromSingleInteger() {
        let tests: [(int: Int, check: Frac)] = [
            (1, Frac(1, 1)),
            (2, Frac(2, 1)),
            (-2, Frac(-2, 1)),
        ]

        tests.forEach { test in
            let result = Fraction(test.int)
            XCTAssertEqual(result, test.check)
        }
    }

    // MARK: methods

    func testReciprocal() {
        let tests: [(frac: Frac, check: Frac)] = [
            (Frac(1, 1), Frac(1, 1)),
            (Frac(1, 2), Frac(2, 1)),
            (Frac(2, 3), Frac(3, 2)),

            (Frac(-1, 2), Frac(-2, 1)),
        ]

        tests.forEach { test in
            let result = test.frac.reciprocal
            XCTAssertEqual(result, test.check)
        }
    }

    func testNegate() {
        let tests: [(frac: Frac, check: Frac)] = [
            (Frac(1, 2), Frac(-1, 2)),
            (Frac(-1, 2), Frac(1, 2)),
        ]

        tests.forEach { test in
            let result = test.frac.negate
            XCTAssertEqual(result, test.check)
        }
    }

    // MARK: operators

    func testAdd() {
        let tests: [(lhs: Frac, rhs: Frac, check: Frac)] = [
            (Frac(1, 1), Frac(1, 1), Frac(2, 1)),
            (Frac(1, 2), Frac(1, 2), Frac(2, 2)),
            (Frac(1, 2), Frac(1, 3), Frac(5, 6)),
            (Frac(1, 2), Frac(1, 6), Frac(4, 6)),
            (Frac(1, 6), Frac(1, 12), Frac(3, 12)),

            (Frac(1, 1), Frac(-1, 1), Frac(0, 1)),
            (Frac(-1, 1), Frac(1, 1), Frac(0, 1)),
            (Frac(-1, 1), Frac(-1, 1), Frac(-2, 1)),

            (Frac(1, 2), Frac(-1, 3), Frac(1, 6)),
            (Frac(-1, 2), Frac(1, 3), Frac(-1, 6)),
            (Frac(-1, 2), Frac(1, 6), Frac(-2, 6)),
        ]

        tests.forEach { test in
            let result = test.lhs + test.rhs
            XCTAssertEqual(result, test.check)
        }
    }

    func testSubtract() {
        let tests: [(lhs: Frac, rhs: Frac, check: Frac)] = [
            (Frac(1, 1), Frac(1, 1), Frac(0, 1)),
            (Frac(1, 2), Frac(1, 2), Frac(0, 2)),
            (Frac(1, 2), Frac(1, 3), Frac(1, 6)),

            (Frac(1, 1), Frac(-1, 1), Frac(2, 1)),
            (Frac(-1, 1), Frac(1, 1), Frac(-2, 1)),
            (Frac(-1, 1), Frac(-1, 1), Frac(0, 1)),

            (Frac(1, 2), Frac(-1, 3), Frac(5, 6)),
            (Frac(-1, 2), Frac(1, 3), Frac(-5, 6)),
            (Frac(-1, 2), Frac(1, 6), Frac(-4, 6)),
        ]

        tests.forEach { test in
            let result = test.lhs - test.rhs
            XCTAssertEqual(result, test.check)
        }
    }

    func testMulitpy() {
        let tests: [(lhs: Frac, rhs: Frac, check: Frac)] = [
            (Frac(1, 1), Frac(1, 1), Frac(1, 1)),
            (Frac(1, 2), Frac(1, 2), Frac(1, 4)),
            (Frac(1, 2), Frac(1, 3), Frac(1, 6)),
            (Frac(1, 2), Frac(2, 6), Frac(2, 12)),
            (Frac(1, 6), Frac(1, 12), Frac(1, 72)),
        ]

        tests.forEach { test in
            let result = test.lhs * test.rhs
            XCTAssertEqual(result, test.check)
        }
    }

    // MARK: math

    func testFractionMath() {
        let tests: [(expression: Frac, check: Frac)] = [
            (Frac(1) + Frac(1, 2), check: Frac(3, 2)),
            (Frac(1) + 1 / (2 + Frac(1, 2)), check: Frac(7, 5)),
            (Frac(1) + 1 / (2 + 1 / (2 + Frac(1, 2))), check: Frac(17, 12)),
        ]
        tests.forEach { test in
            XCTAssertEqual(test.expression, test.check)
        }
    }
}
