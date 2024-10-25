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

        for n in UInt(0) ... 30 {
            let index = primes.binarySearchIndex(for: n)
            guard primes.indices.contains(index) else {
                XCTAssert(primes.last! < n)
                continue
            }

            if index > 0 {
                XCTAssert(primes[index - 1] < n)
            }
            XCTAssert(n <= primes[index])
        }
    }

    func testBinarySearchElement() {
        let evens = stride(from: 0, through: 30, by: 2).asArray

        for n in 0 ... 31 {
            guard let index = evens.binarySearchValidIndex(forOrBefore: n) else {
                XCTAssert(evens.last! < n)
                continue
            }
            XCTAssertEqual(evens[index], (n / 2) * 2)
        }
    }
}
