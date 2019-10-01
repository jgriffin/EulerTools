//
//  Digits.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/13/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

struct Digits {
    static func powerOfTenBigger<T: BinaryInteger>(than n: T) -> T {
        var pow: T = 1
        repeat {
            pow *= 10
        } while pow <= n
        return pow
    }

    static func digitsOf<T: BinaryInteger, R: BinaryInteger>(_ n: T) -> [R] {
        var digits = [R]()
        var m = n
        while m > 0 {
            digits.append(R(m % 10))
            m /= 10
        }
        return digits.reversed()
    }

    static func digitCountOf<T: BinaryInteger, R: BinaryInteger>(_ n: T) -> R {
        var digitCount = R(0)
        var m = n
        while m > 0 {
            digitCount += 1
            m /= 10
        }
        return digitCount
    }
}
