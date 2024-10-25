//
//  BitsTests.swift
//  ProjectEulerTests
//
//  Created by John Griffin on 4/1/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import EulerTools
import XCTest

class BitsTests: XCTestCase {
    func testCountBits() {
        let tests: [(test: Int, check: Int)] = [
            (0, 0), (1, 1), (2, 1), (3, 2),
        ]
        for (test, check) in tests {
            let result = Bits.countBits(test)
            XCTAssertEqual(result, check, "countBits of \(test)")
        }
    }

    func testIndicesOfSetBits() {
        let tests: [(test: Int, check: [Int])] = [
            (0, []), (1, [0]), (2, [1]), (3, [1, 0]),
        ]
        for (test, check) in tests {
            let result = Bits.indicesOfSetBits(test)
            XCTAssertEqual(result, check, "countBits of \(test)")
        }
    }

    func testIndicesOfSetBitsBigInt() {
        let tests: [(test: _BigInt<UInt64>, check: [Int])] = [
            (0, []), (1, [0]), (2, [1]), (3, [1, 0]),
        ]
        for (test, check) in tests {
            let result = test.indiciesForSetBits()
            XCTAssertEqual(result, check, "countBits of \(test)")
        }
    }

    func testIndicesOfSetBitsBigIntShifted() {
        let tests: [(test: _BigInt<UInt64>, check: [Int])] = [
            (0, []), (1, [64]), (2, [65]), (3, [65, 64]),
        ]
        for (test, check) in tests {
            let test2 = test * (1 << 64)
            let result = test2.indiciesForSetBits()
            XCTAssertEqual(result, check, "countBits of \(test2)")
        }
    }

    func testIndividualBits() {
        let tests: [(test: Int, check: [Int])] = [
            (3, [1, 2]),
            (8, [8]),
            (13, [1, 4, 8]),
            (0, []),
        ]
        for test in tests {
            let result = test.test.individualBits
            XCTAssertEqual(result, test.check)
        }
    }
}
