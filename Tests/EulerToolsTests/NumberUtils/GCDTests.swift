//
//  GCDTests.swift
//
//
//  Created by Griff on 1/3/21.
//

import EulerTools
import XCTest

final class GCDTests: XCTestCase {
    func testExtendedGCD() {
        let tests: [(a: Int, b: Int, gcd: Int, x: Int, y: Int)] = [
            (240, 46, 2, -9, 47),
            (46, 240, 2, 47, -9),
        ]

        for test in tests {
            let result = Int.extendedGCD(test.a, test.b)
            XCTAssertEqual(result.gcd, test.gcd)
            XCTAssertEqual(result.x, test.x)
            XCTAssertEqual(result.y, test.y)
        }
    }

    func testModularMultiplicativeInverse() {
        let tests: [(a: Int, m: Int, check: Int?)] = [
            (2, 4, nil), // not-congruent
            (4, 7, 2),
            (3, 11, 4),
            (7, 3, 1),
            (7, 4, 3),
        ]

        for test in tests {
            let result = Int.modularMultiplicativeInverse(test.a, test.m)
            XCTAssertEqual(result, test.check)
        }
    }
}
