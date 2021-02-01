//
//
// Created by John Griffin on 1/31/21
//

import Foundation

public extension SquareBoard {
    struct PositionMask4: SquareBoardPositionMask {
        public typealias PosMask = UInt16
        public let mask: PosMask

        // MARK: SquareBoardPositionMask

        public static func make(_ mask: PosMask) -> PositionMask4 {
            .init(mask: mask)
        }

        public static func make(r: Int, c: Int) -> PositionMask4 {
            assert(r < 4 && c < 4)
            return .init(mask: Self.maskFrom(r: r, c: c))
        }

        // MARK: r,c math

        public static let colMask2Int: [PosMask: Int] = [
            1: 0, 2: 1, 4: 2, 8: 3,
        ]
        public static let rowShift = 4
        public static let rowMask: PosMask = (1 << rowShift) - 1
    }
}
