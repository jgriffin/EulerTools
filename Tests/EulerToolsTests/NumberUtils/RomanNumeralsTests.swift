//
//  RomanNumeralsTests.swift
//  ProjectEulerTests
//
//  Created by John Griffin on 3/31/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import EulerTools
import XCTest

class RomanNumeralsTests: XCTestCase {
    func testIntValueOf() {
        let intValueOfTests: [(test: String, check: Int)] = [
            ("I", 1), ("V", 5), ("X", 10), ("L", 50), ("C", 100), ("D", 500), ("M", 1000),
            ("VI", 6), ("VII", 7), ("IV", 4), ("IIV", 3),
            ("XIIIIIII", 17), ("XVII", 17),
            ("MMMMDCLXXII", 4672),
        ]

        intValueOfTests.forEach { test, check in
            let result = RomanNumerals.intValue(of: test)
            XCTAssertEqual(result, check, "roman numeral:\(test)")
        }
    }

    func testRomanValueOf() {
        let romanValueOfTests: [(check: String, test: Int)] = [
            ("I", 1), ("V", 5), ("X", 10), ("L", 50), ("C", 100), ("D", 500), ("M", 1000),
            ("VI", 6), ("VII", 7), ("IV", 4), ("IX", 9), ("XVII", 17),
            ("XIX", 19),

            ("XL", 40), ("XC", 90), ("LXX", 70), ("LXXX", 80),
            ("CD", 400), ("CM", 900), ("DCCC", 800),
            ("MMMMDCLXXII", 4672),
        ]

        romanValueOfTests.forEach { check, test in
            let result = RomanNumerals.romanValue(of: test)
            XCTAssertEqual(result, check, "decimal : \(test)")
        }
    }
}
