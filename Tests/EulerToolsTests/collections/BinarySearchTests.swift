//
//  BinarySearchTests.swift
//
//
//  Created by John Griffin on 1/13/20.
//

import EulerTools
import XCTest

class BinarySearchTests: XCTestCase {
    func testBinarySearch() {
        let primes = Primes.primesUpto(30)

        (UInt(0) ... 30).forEach { n in
            let index = primes.binarySearchIndex(for: n)
            guard primes.indices.contains(index) else {
                XCTAssert(primes.last! < n)
                return
            }

            if index > 0 {
                XCTAssert(primes[index - 1] < n)
            }
            XCTAssert(n <= primes[index])
        }
    }

    func testBinarySearchElement() {
        let evens = stride(from: 0, through: 30, by: 2).asArray

        (0 ... 31).forEach { n in
            guard let index = evens.binarySearchValidIndex(forOrBefore: n) else {
                XCTAssert(evens.last! < n)
                return
            }
            XCTAssertEqual(evens[index], (n / 2) * 2)
        }
    }
}
