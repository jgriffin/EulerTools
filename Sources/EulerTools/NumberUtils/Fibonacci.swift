//
//  Fibonacci.swift
//  
//
//  Created by John Griffin on 4/18/20.
//

import Foundation

public class Fibonacci {
    public static var uint = FibonacciMemoized<UInt>()
    public static var uint64 = FibonacciMemoized<UInt64>()
}

public class FibonacciMemoized<I: FixedWidthInteger> {
    private let fibMemoizer = Memoizer<I, I>()
    
    public func fib(of n: I) -> I {
        assert(n >= 0)
        
        if n == 0 {
            return 0
        }
        if n == 1 {
            return 1
        }
        
        return fibMemoizer.memoized(n) {
            return fib(of: n-2) + fib(of: n-1)
        }
    }
}
