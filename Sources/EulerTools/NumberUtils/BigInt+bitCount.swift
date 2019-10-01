//
//  BigInt+bitCount.swift
//  ProjectEuler
//
//  Created by John Griffin on 4/1/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

extension _BigInt {
    var nonzeroBitCount: Int {
        return _data.reduce(0) { result, w in result + w.nonzeroBitCount }
    }

    // return the indicies of set bits from left to right
    func indiciesForSetBits() -> [Int] {
        var indices = [Int]()

        var index = 0
        var remain = self
        while remain != 0 {
            if remain & 1 == 1 {
                indices.append(index)
            }
            index += 1
            remain >>= 1
        }
        return indices.reversed()
    }
}
