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

        public static func make(_ rc: RC) -> PositionMask8 {
            assert(rc.r < rowShift && rc.c < rowShift)
            return .init(mask: maskFrom(rc))
        }

        // MARK: r,c math

        public static let colMask2Int: [PosMask: Int] = [
            1: 0, 2: 1, 4: 2, 8: 3, 16: 4, 32: 5, 64: 6, 128: 7,
        ]
        public static let rowShift = 8
        public static let rowMask: PosMask = (1 << rowShift) - 1
    }
}

public extension SquareBoard.PositionMask8.PosMask {
    func bitString(_ rc: SquareBoard.RC) -> String {
        bitString(rowShift: 8, rowMax: rc.r, colMax: rc.c)
    }
}
