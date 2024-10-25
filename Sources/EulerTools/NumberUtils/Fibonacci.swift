//
//  Fibonacci.swift
//
//
//  Created by John Griffin on 4/18/20.
//

import Foundation

@MainActor public enum Fibonacci {
    public static var uint = FibonacciMemoized<UInt>()
    public static var uint64 = FibonacciMemoized<UInt64>()
}

public actor FibonacciMemoized<I: FixedWidthInteger> {
    public func fib(of n: I) -> I { fibMemoized(n) }

    private let fibMemoized = Memoizer<I, I>.memoizedFnRecursive { n, fib in
        assert(n >= 0)
        if n == 0 { return 0 }
        if n == 1 { return 1 }
        return fib(n - 2) + fib(n - 1)
    }
}
