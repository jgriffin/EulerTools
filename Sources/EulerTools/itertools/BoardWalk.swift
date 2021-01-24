//
//  BoggleWalk.swift
//
//
//  Created by John Griffin on 3/28/20.
//

import Foundation

/**
 In the game of bogle, you've got an MxN board where you can move in any direction, but can't revisit a square
 The generalized verision of this is common enought to deserve class
 */
public class BoardWalk {
    public let boardSize: BoardSize
    public let allowedSteps: [Step]

    public init(boardSize: BoardSize, allowedSteps: [Step]) {
        self.boardSize = boardSize
        self.allowedSteps = allowedSteps
    }

    public typealias BoardSize = (rows: Int, cols: Int)
    public typealias Step = (dx: Int, dy: Int)
    public typealias Path = [Square]

    // MARK: index helpers

    // MARK: index helpers

    public func allSquares() -> [Square] {
        var squares = [Square]()
        for row in 0 ..< boardSize.rows {
            for col in 0 ..< boardSize.cols {
                squares.append(Square(row, col))
            }
        }
        return squares
    }

    public func linearIndexForSquare(_ square: Square) -> Int {
        square.y * boardSize.cols + square.x
    }

    public func linearIndiciesForPath(_ path: Path) -> [Int] {
        path.map { linearIndexForSquare($0) }
    }

    public static let squareSteps: [Step] = [(0, -1), (0, 1), (-1, 0), (1, 0)]
    public static let diagonalSteps: [Step] = [(1, -1), (1, 1), (-1, 1), (-1, -1)]
    public static let squareAndDiagonalSteps: [Step] = squareSteps + diagonalSteps
}

public extension BoardWalk {
    struct Square: Equatable, CustomStringConvertible {
        public let x, y: Int

        public init(_ x: Int, _ y: Int) {
            self.x = x
            self.y = y
        }

        public func move(_ step: Step) -> Square {
            Square(x + step.dx, y + step.dy)
        }

        public func ifValidOn(_ boardSize: BoardSize) -> Square? {
            guard x.isBetween(lower: 0, upper: boardSize.cols),
                  y.isBetween(lower: 0, upper: boardSize.rows)
            else {
                return nil
            }
            return self
        }

        public var description: String { "(\(x),\(y))" }
    }
}

public extension BoardWalk {
    class Stepper: IteratorProtocol, Sequence {
        public let square: Square
        public let board: BoardWalk

        public init(from square: Square,
                    onBoard board: BoardWalk)
        {
            self.square = square
            self.board = board
        }

        // MARK: iteratorprotocol

        var stepIterator: IndexingIterator<[Step]>!

        public func next() -> Square? {
            while true {
                if stepIterator == nil {
                    stepIterator = board.allowedSteps.makeIterator()
                }

                guard let nextStep = stepIterator.next() else {
                    return nil
                }
                guard let nextSquare = square
                    .move(nextStep)
                    .ifValidOn(board.boardSize)
                else {
                    continue
                }
                return nextSquare
            }
        }

        // MARK: sequence

        public func makeIterator() -> BoardWalk.Stepper {
            Stepper(from: square, onBoard: board)
        }
    }

    class Walker: IteratorProtocol, Sequence {
        let staringSquare: Square
        let board: BoardWalk
        public let isDeadEndPath: IsDeadEndPath?

        // for many algorithms, we know the path isn't going to be interesting
        // return true to prune the branch
        public typealias IsDeadEndPath = (Path) -> Bool

        public init(from square: Square,
                    onBoard board: BoardWalk,
                    isDeadEndPath: IsDeadEndPath?)
        {
            staringSquare = square
            self.board = board
            self.isDeadEndPath = isDeadEndPath
        }

        // MARK: iteratorprotocol

        var squareSteppers: [Stepper]!

        public func next() -> Path? {
            while true {
                if squareSteppers == nil {
                    // start from the beginning
                    squareSteppers = [Stepper(from: staringSquare, onBoard: board)]
                }

                guard !squareSteppers.isEmpty else {
                    // we've gone through and backtracked and we're done
                    return nil
                }

                guard let nextSquare = squareSteppers.last!.next() else {
                    // we've exhaused this stepper, backtrack
                    squareSteppers.removeLast()
                    continue
                }

                guard !squareSteppers.contains(where: { $0.square == nextSquare }) else {
                    // we've been there before, keep looking
                    continue
                }

                // setup stepper for next iteration
                squareSteppers.append(Stepper(from: nextSquare, onBoard: board))

                let path = squareSteppers.map(\.square)

                if isDeadEndPath?(path) == true {
                    // prune this path
                    squareSteppers.removeLast()
                    continue
                }

                // but first return this square
                return path
            }
        }

        // MARK: sequence

        public func makeIterator() -> Walker {
            Walker(from: staringSquare,
                   onBoard: board,
                   isDeadEndPath: isDeadEndPath)
        }
    }
}
