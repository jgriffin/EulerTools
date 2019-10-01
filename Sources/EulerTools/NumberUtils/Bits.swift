//
//  Bits.swift
//  ProjectEuler
//
//  Created by John Griffin on 4/1/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

struct Bits {
    static func countBits(_ n: Int) -> Int {
        var remain = n
        var cBits = 0
        while remain != 0 {
            cBits += 1
            remain = remain & (remain - 1)
        }
        return cBits
    }

    static func indicesOfSetBits(_ n: Int) -> [Int] {
        var indices = [Int]()
        var index = -1

        var remain = n
        while remain != 0 {
            let trailingZeros = remain.trailingZeroBitCount
            index += trailingZeros + 1
            indices.append(index)
            remain >>= trailingZeros + 1
        }
        return indices.reversed()
    }
}
