//
//  SuDokuSolver.swift
//  ProjectEuler
//
//  Created by John Griffin on 5/10/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

class SuDokuSolver {
    let original: SuDokuBoard

    var current: SuDokuBoard
    var currentGrid: SuDokuGrid

    init(_ board: SuDokuBoard) {
        original = board
        current = board
        currentGrid = SuDokuGrid.from(board: board)
    }

    func solve() {
        while !current.isSolved {
            let didMakeProgress = makeProgressSingleNumber()
            assert(didMakeProgress)
        }
    }

    func makeProgressSingleNumber() -> Bool {
        var didMakeProgress = false

        for (index, digit) in current.digits.enumerated() where digit == 0 {
            let availableMask = currentGrid.availableMask(for: index)
            if let singleNumber = availableMask.singleNumber {
                // only one choice, place the tile
                didMakeProgress = true
                updateCurrent(index, to: singleNumber)
            }
        }

        return didMakeProgress
    }

    fileprivate func updateCurrent(_ index: Int, to number: UInt8) {
        current.digits[index] = number
        currentGrid.updateMasks(index: index, subtracting: number)
    }

    func dump() {
        (0 ... 8).forEach { row in
            let line = (0 ... 8).map { col -> String in
                let index = row * 9 + col
                let digit = current.digits[index]
                if digit != 0 {
                    return "----\(digit)----"
                } else {
                    return "\(currentGrid.availableMask(for: index))"
                }
            }.joined(separator: " ")
            print(line)
        }
    }
}
