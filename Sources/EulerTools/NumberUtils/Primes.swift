//
//  Primes.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/11/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

class Primes {
    static let instance = Primes()

    static func isPrime(_ n: UInt) throws -> Bool {
        if n <= 104_729 {
            return binarySearch(tenThousandPrimes, key: n) != nil
        }

        return try checkWithMillerRabin(n)
    }

    static func primesUpto(_ upto: UInt) -> [UInt] {
        var primes: [UInt] = Array(tenThousandPrimes.prefix { $0 <= upto })

        var i = (primes.last ?? 0) + 1
        while i <= upto {
            if try! isPrime(i) {
                primes.append(i)
            }
            i += 1
        }

        return primes
    }
}
