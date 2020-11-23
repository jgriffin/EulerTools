//
//  Factorial.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/18/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

public class Factorial {
    public static let instance = Factorial()

    public let memoiser = Memoizer<UInt, UInt>()

    public func factorial(_ n: UInt) -> UInt {
        memoiser.memoized(n) {
            if n <= 1 {
                return 1
            }
            return n * factorial(n - 1)
        }
    }
}
