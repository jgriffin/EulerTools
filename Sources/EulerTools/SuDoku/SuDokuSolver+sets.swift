//
//  SuDokuSolver+sets.swift
//  ProjectEuler
//
//  Created by John Griffin on 5/10/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

extension SuDoku.Solver {
    static func groupSets(for board: SuDoku.Board) -> [Set<UInt8>] {
        return groupIndices.map { indices in
            Set(indices.map { board.digits[$0] })
        }
    }

    static let groupIndices: [[Int]] = rowIndices + colIndices + squareIndices

    static let groupIndexesForIndex: [Int: [Int]] = {
        var indexGroups = [Int: [Int]]()

        for (groupIndex, indices) in groupIndices.enumerated() {
            for index in indices {
                indexGroups[index, default: []] += [groupIndex]
            }
        }
        return indexGroups
    }()

    static let rowIndices: [[Int]] = {
        (0 ... 8).map { row in
            (0 ... 8).map { col in 9 * row + col }
        }
    }()

    static let colIndices: [[Int]] = {
        (0 ... 8).map { col in
            (0 ... 8).map { row in 9 * row + col }
        }
    }()

    static let squareIndices: [[Int]] = {
        let squareStart = [0, 3, 6, 0 + 27, 3 + 27, 6 + 27, 0 + 54, 3 + 54, 6 + 54]
        return squareStart.map { start in
            [0, 9, 18].flatMap { rowOffset in
                [0, 1, 2].map { start + $0 + rowOffset }
            }
        }
    }()
}
