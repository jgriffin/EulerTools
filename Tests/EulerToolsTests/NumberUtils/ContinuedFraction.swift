//
//  ContinuedFraction.swift
//
//
//  Created by John Griffin on 4/19/20.
//

import EulerTools
import XCTest

class ContinuedFractionTests: XCTestCase {
    typealias CF = ContinuedFraction
    typealias F = Fraction

    let twos = sequence(first: 2, next: { _ in 2 }).any()

    func testWholeInitializers() {
        let tests: [(cf: CF, check: F)] = [
            (CF(whole: 0, []), check: 0),
            (CF(whole: 1, [2]), check: F(3, 2)),
            (CF(whole: 1, [2, 2]), check: F(7, 5)),
            (CF(whole: 1, [2, 2, 2]), check: F(17, 12)),
            (CF([1, 2, 2, 2]), check: F(17, 12)),
        ]
        tests.forEach { test in
            XCTAssertEqual(test.cf.expansion(), test.check)
        }
    }

    func testSequenceInitializers() {
        let tests: [(cf: CF, max: Int, check: F)] = [
            (CF([1, 2, 2, 2].any()), 4, check: F(17, 12)),
            (CF(.join([1].any(), twos)), 4, check: F(17, 12)),
            (CF(whole: 1, twos), 4, check: F(17, 12)),
        ]
        tests.forEach { test in
            let result = test.cf.expansion(maxTerms: test.max)
            XCTAssertEqual(result, test.check)
        }
    }
}
