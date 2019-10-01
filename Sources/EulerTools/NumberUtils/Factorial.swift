//
//  Factorial.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/18/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

class Factorial {
    static let instance = Factorial()

    let memoiser = Memoizer<UInt, UInt>()

    func factorial(_ n: UInt) -> UInt {
        return memoiser.memoized(n) {
            if n <= 1 {
                return 1
            }
            return n * factorial(n - 1)
        }
    }
}
