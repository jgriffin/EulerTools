//
//  File.swift
//  ProjectEulerTests
//
//  Created by John Griffin on 3/13/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import EulerTools
import XCTest

class DigitsTests: XCTestCase {
    func testPowerOfTenBigger() {
        let tests: [(test: UInt, check: UInt)] = [
            (1, 10), (9, 10), (10, 100), (11, 100), (99, 100), (100, 1000),
        ]
        tests.forEach { test in
            XCTAssertEqual(Digits.powerOfTenBigger(than: test.test), test.check)
        }
    }

    func testDigitsOf() {
        let digits: [Int] = Digits.digitsOf(123_456)
        XCTAssertEqual(digits, [1, 2, 3, 4, 5, 6])
    }
}
