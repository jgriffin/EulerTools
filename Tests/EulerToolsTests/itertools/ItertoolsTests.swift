//
//  ItertoolsTests.swift
//  ProjectEulerTests
//
//  Created by John Griffin on 3/31/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import EulerTools
import XCTest

class ItertoolsTests: XCTestCase {
    func testProduct() {
        let tests: [([Int], [[Int]])] = [
            ([1], [[1]]),
            ([1, 2], [[1, 1], [1, 2], [2, 1], [2, 2]]),
        ]
        for (test, check) in tests {
            let result = Array(product(test, repeated: test.count))
            XCTAssertEqual(result, check, "\(test)")
        }
    }

    func testPermutation() {
        let tests: [([Int], [[Int]])] = [
            ([1], [[1]]),
            ([1, 2], [[1, 1], [1, 2], [2, 1], [2, 2]]),
        ]
        for (test, check) in tests {
            let result = test.permutations(repeatingElements: true)
            XCTAssertEqual(Array(result), check, "\(test)")
        }
    }

    func testCombinations() {
        let tests: [([Int], [[Int]])] = [
            ([1], [[1]]),
            ([1, 2], [[1, 2]]),
            ([1, 2, 3], [[1, 2, 3]]),
        ]
        for (test, check) in tests {
            let result = test.combinations(length: test.count)
            XCTAssertEqual(result, check, "\(test)")
        }
    }

    func testCombinationsWithRepeatingElements() {
        let tests: [([Int], [[Int]])] = [
            ([1], [[1]]),
            ([1, 2], [[1, 1], [1, 2], [2, 2]]),
        ]
        for (test, check) in tests {
            let result = test.combinations(length: test.count, repeatingElements: true)
            XCTAssertEqual(result, check, "\(test)")
        }
    }
}
