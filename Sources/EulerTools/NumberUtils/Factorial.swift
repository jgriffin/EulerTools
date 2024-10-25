//
//  Factorial.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/18/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

public actor Factorial {
    public static let instance = Factorial()

    public func factorial(_ n: UInt) -> UInt { factorialMemoized(n) }

    private let factorialMemoized = Memoizer<UInt, UInt>.memoizedFnRecursive { n, fact in
        if n <= 1 { return 1 }
        return n * fact(n - 1)
    }
}
