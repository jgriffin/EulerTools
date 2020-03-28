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
            guard let index = primes.binarySearch(indexFor: n) else {
                XCTAssert(primes.last! < n, "n: \(n)")
                return
            }

            if index > 0 {
                XCTAssert(primes[index - 1] < n)
            }
            XCTAssert(n <= primes[index])
        }
    }
}
