//
//  Solver.swift
//  ProjectEuler
//
//  Created by John Griffin on 5/10/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

public extension SuDoku {
    class Solver {
        public let original: Board
        public var current: Board
        var currentGrid: BoardMasks

        public init(_ board: Board) {
            original = board
            current = board
            currentGrid = BoardMasks.from(board: board)
        }

        public init(_ solver: Solver) {
            original = solver.original
            current = solver.current
            currentGrid = solver.currentGrid
        }

        // MARK: solve

        public enum SolveError: Error {
            case needsImplemention, unsolvable
        }

        public func solve() throws -> Board {
            while !current.isSolved {
                if makeProgressSingleNumber() {
                    continue
                }

                try solveWithGuessAndTest()
            }
            return current
        }

        // MARK: helpers

        private func updateCurrentDigit(at index: Int, to number: Digit) {
            current.digits[index] = number
            currentGrid.updateMasks(index: index,
                                    subtracting: DigitMask(number: number))
        }

        private func makeProgressSingleNumber() -> Bool {
            var didMakeProgress = false

            for (index, digit) in current.digits.enumerated() where digit == 0 {
                let availableMask = currentGrid.availableMask(for: index)
                guard let singleNumber = availableMask.singleDigit else {
                    continue
                }

                // only one choice, place the tile
                didMakeProgress = true
                updateCurrentDigit(at: index, to: singleNumber)
            }

            return didMakeProgress
        }

        private func solveWithGuessAndTest() throws {
            // find fewest available digits count
            var fewest: (index: Int, digits: [Digit])?

            for (index, digit) in current.digits.enumerated() where digit == 0 {
                let digits = currentGrid.availableMask(for: index).availableDigits
                if digits.count < (fewest.map(\.digits.count) ?? 10) {
                    fewest = (index, digits)
                }
            }

            guard let guess = fewest else {
                throw SolveError.unsolvable
            }

            for digit in guess.digits {
                let guessSolver = Solver(self)
                guessSolver.updateCurrentDigit(at: guess.index, to: digit)

                do {
                    _ = try guessSolver.solve()
                    current = guessSolver.current
                    currentGrid = guessSolver.currentGrid
                    return
                } catch {
                    // keep trying
                }
            }

            throw SolveError.unsolvable
        }

        func dump() {
            for row in 0 ... 8 {
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
}
