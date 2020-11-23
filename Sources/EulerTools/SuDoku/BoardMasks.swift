//
//  BoardMasks.swift
//  ProjectEuler
//
//  Created by John Griffin on 5/10/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

extension SuDoku {
    public struct BoardMasks: Equatable, CustomStringConvertible {
        public var rowMasks: [DigitMask]
        public var colMasks: [DigitMask]
        public var squareMasks: [DigitMask]

        public init(initial: DigitMask = .allDigits) {
            rowMasks = [DigitMask](repeating: initial, count: 9)
            colMasks = [DigitMask](repeating: initial, count: 9)
            squareMasks = [DigitMask](repeating: initial, count: 9)
        }

        public static func maskIndices(for index: Int) -> (r: Int, c: Int, sq: Int) {
            let r = index / 9
            let c = index % 9
            let (sqRow, sqCol) = (index / 27, (index / 3) % 3)
            return (r, c, sqRow * 3 + sqCol)
        }

        public func availableMask(for index: Int) -> DigitMask {
            let (r, c, sq) = BoardMasks.maskIndices(for: index)
            return rowMasks[r].intersection(colMasks[c]).intersection(squareMasks[sq])
        }

        public mutating func updateMasks(index: Int, subtracting mask: DigitMask) {
            let (r, c, sq) = BoardMasks.maskIndices(for: index)

            rowMasks[r].subtract(mask)
            colMasks[c].subtract(mask)
            squareMasks[sq].subtract(mask)
        }

        func countAllMasksForAllIndices(matching: (DigitMask) -> Bool) -> Int {
            (0 ..< 9 * 9).reduce(0) { (result, index) -> Int in
                let (r, c, sq) = BoardMasks.maskIndices(for: index)
                return result +
                    (matching(rowMasks[r]) ? 1 : 0) +
                    (matching(colMasks[c]) ? 1 : 0) +
                    (matching(squareMasks[sq]) ? 1 : 0)
            }
        }

        public var description: String {
            let rows = "rows: " + rowMasks.map(String.init).joined(separator: " ")
            let cols = "cols: " + colMasks.map(String.init).joined(separator: " ")
            let sqrs = "sqrs: " + squareMasks.map(String.init).joined(separator: " ")
            return "\(rows)\n\(cols)\n\(sqrs)"
        }

        func dump() {
            let rows = "rows: " + rowMasks.map(String.init).joined(separator: " ")
            let cols = "cols: " + colMasks.map(String.init).joined(separator: " ")
            let sqrs = "sqrs: " + squareMasks.map(String.init).joined(separator: " ")
            print(rows)
            print(cols)
            print(sqrs)
        }

        static let indicesForSquares: [[Int]] = [
            [0, 1, 2, 9, 10, 11, 18, 19, 20],
            [3, 4, 5, 12, 13, 14, 21, 22, 23],
            [6, 7, 8, 15, 16, 17, 24, 25, 26],
            [27, 28, 29, 36, 37, 38, 45, 46, 47],
            [30, 31, 32, 39, 40, 41, 48, 49, 50],
            [33, 34, 35, 42, 43, 44, 51, 52, 53],
            [54, 55, 56, 63, 64, 65, 72, 73, 74],
            [57, 58, 59, 66, 67, 68, 75, 76, 77],
            [60, 61, 62, 69, 70, 71, 78, 79, 80],
        ]

        static func from(board: Board) -> BoardMasks {
            var grid = BoardMasks()

            for (index, number) in board.digits.enumerated() where number != 0 {
                grid.updateMasks(index: index,
                                 subtracting: DigitMask(number: number))
            }

            return grid
        }
    }
}
