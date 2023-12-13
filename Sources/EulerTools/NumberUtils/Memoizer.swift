//
//  Memoizer.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/18/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

/**
 Can be used two ways (at least)

 1. As just a cache around a function
    e.g. memoizer.memoize(n, fn)

 2. Or to create function which is itself, memoized:
     e.g. let memoized = Memoizer.memoizedFn(fn)
        memoized(n)

 */
public class Memoizer<Input: Hashable, Result> {
    public typealias FN = (Input) -> Result
    private var memos = [Input: Result]()

    public required init() {}

    public func memoized(_ input: Input, _ fn: FN) -> Result {
        if let result = memos[input] {
            return result
        }
        let result = fn(input)
        memos[input] = result
        return result
    }

    // MARK: - factory methods

    // Non Recursive
    public static func memoizedFn(_ fn: @escaping FN) -> FN {
        let memoizer = Self()
        return { memoizer.memoized($0, fn) }
    }

    // Recursion supporting version
    public static func memoizedFnRecursive(_ fnRecurse: @escaping (Input, FN) -> Result) -> FN {
        let memoizer = Self()

        func wrap(x: Input) -> Result {
            memoizer.memoized(x) { x in
                fnRecurse(x, wrap)
            }
        }

        return wrap
    }
}
