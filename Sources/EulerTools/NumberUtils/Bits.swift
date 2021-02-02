//
//  Bits.swift
//  ProjectEuler
//
//  Created by John Griffin on 4/1/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

public extension BinaryInteger {
    var bitCount: Int {
        var remain = self
        var cBits = 0
        while remain != 0 {
            cBits += 1
            remain = remain & (remain - 1)
        }
        return cBits
    }

    var bitIndices: [Int] {
        var indices = [Int]()
        var index = -1

        var remain = self
        while remain != 0 {
            let trailingZeros = remain.trailingZeroBitCount
            index += trailingZeros + 1
            indices.append(index)
            remain >>= trailingZeros + 1
        }
        return indices.reversed()
    }

    var individualBits: [Self] {
        var bits = [Self]()

        var remain = self
        while remain != 0 {
            let lastBit = remain & ~(remain - 1)
            bits.append(lastBit)
            remain = remain ^ lastBit
        }

        return bits
    }

    // bitString
    // string representation of bits
    // in lsb lowerLeft -> upperRight order
    func bitString(
        rowShift: Int,
        rowMax: Int,
        colMax: Int,
        rowSeparator: String = "\n"
    ) -> String {
        (0 ..< rowMax).map { r -> String in
            (0 ..< colMax).map { c -> Character in
                isBitSet(r * rowShift + c) ? "1" : "0"
            }
            .asString
        }
        .joined(separator: rowSeparator)
    }

    func isBitSet(_ index: Int) -> Bool {
        self & (1 << index) != 0
    }
}

public enum Bits {
    // FUTURE: remove, here for backward compatability
    public static func countBits<T: BinaryInteger>(_ n: T) -> Int {
        n.bitCount
    }

    public static func indicesOfSetBits<T: BinaryInteger>(_ n: T) -> [Int] {
        n.bitIndices
    }
}
