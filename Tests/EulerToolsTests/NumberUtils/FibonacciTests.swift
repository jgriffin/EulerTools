//
//  FibonacciTests.swift
//  
//
//  Created by John Griffin on 4/18/20.
//

import EulerTools
import XCTest

class FibonacciTests: XCTestCase {
    
    func testFibonacci() {
        let fibs: [UInt] = [0,1,1,2,3,5,8,13,21,34,55,89,144]
        
        fibs.enumerated().forEach { test in
            let result = Fibonacci.uint.fib(of: UInt(test.offset))
            XCTAssertEqual(result, test.element)
        }
    }
}
