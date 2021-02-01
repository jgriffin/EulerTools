//
//
// Created by John Griffin on 1/31/21
//

import Foundation

public extension SquareBoard {
    struct PositionMask8: SquareBoardPositionMask, CustomStringConvertible {
        public typealias PosMask = UInt64
        public let mask: PosMask

        // MARK: SquareBoardPositionMask

        public static func make(_ mask: PosMask) -> PositionMask8 {
            .init(mask: mask)
        }

        public static func make(r: Int, c: Int) -> PositionMask8 {
            assert(r < Self.rowShift && c < Self.rowShift)
            return .init(mask: Self.maskFrom(r: r, c: c))
        }

        // MARK: r,c math

        public static let colMask2Int: [PosMask: Int] = [
            1: 0, 2: 1, 4: 2, 8: 3, 16: 4, 32: 5, 64: 6, 128: 7,
        ]
        public static let rowShift = 8
        public static let rowMask: PosMask = (1 << rowShift) - 1
    }
}
