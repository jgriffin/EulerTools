//
//
// Created by John Griffin on 1/31/21
//

import Foundation

public protocol SquareBoardPositionMask: SquareBoardPosition {
    associatedtype PosMask: BinaryInteger

    var mask: PosMask { get }

    static func make(_ mask: PosMask) -> Self

    static var colMask2Int: [PosMask: Int] { get }
    static var rowShift: Int { get }
    static var rowMask: PosMask { get }
}

public extension SquareBoardPositionMask {
    static var rowMask: PosMask { (1 << rowShift) - 1 }

    static func maskFrom(r: Int, c: Int) -> PosMask {
        (PosMask(1) << c) << (rowShift * r)
    }

    var r: Int {
        var remain = mask
        var row = 0
        while remain > Self.rowMask {
            remain >>= Self.rowShift
            row += 1
        }
        return row
    }

    var c: Int {
        let col = mask >> (r * Self.rowShift)
        return Self.colMask2Int[col]!
    }
}
