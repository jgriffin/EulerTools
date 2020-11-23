//
//  BoggleWalkTests.swift
//
//
//  Created by John Griffin on 3/28/20.
//

import EulerTools
import XCTest

class BoardWalkTests: XCTestCase {
    typealias Sq = BoardWalk.Square
    typealias Path = [Sq]

    let boardWalk3x3Square = BoardWalk(boardSize: (rows: 3, cols: 3),
                                       allowedSteps: BoardWalk.squareSteps)

    func testStepper() {
        let tests: [(start: Sq, check: [Sq])] = [
            (Sq(0, 0), [Sq(0, 1), Sq(1, 0)]),
            (Sq(1, 0), [Sq(1, 1), Sq(0, 0), Sq(2, 0)]),
            (Sq(2, 0), [Sq(2, 1), Sq(1, 0)]),
            (Sq(0, 1), [Sq(0, 0), Sq(0, 2), Sq(1, 1)]),
            (Sq(1, 1), [Sq(1, 0), Sq(1, 2), Sq(0, 1), Sq(2, 1)]),
            (Sq(2, 1), [Sq(2, 0), Sq(2, 2), Sq(1, 1)]),
            (Sq(0, 2), [Sq(0, 1), Sq(1, 2)]),
            (Sq(1, 2), [Sq(1, 1), Sq(0, 2), Sq(2, 2)]),
            (Sq(2, 2), [Sq(2, 1), Sq(1, 2)]),
        ]
        tests.forEach { test in
            let stepper = BoardWalk.Stepper(from: test.start, onBoard: boardWalk3x3Square)
            XCTAssertEqual(Array(stepper), test.check)
        }
    }

    func testWalker() {
        let walker = BoardWalk.Walker(from: Sq(0, 0),
                                      onBoard: boardWalk3x3Square,
                                      isDeadEndPath: { path in path.count > 3 })
        let paths = Array(walker)

        let check: [Path] = [
            [Sq(0, 0), Sq(0, 1)],
            [Sq(0, 0), Sq(0, 1), Sq(0, 2)],
            [Sq(0, 0), Sq(0, 1), Sq(1, 1)],
            [Sq(0, 0), Sq(1, 0)],
            [Sq(0, 0), Sq(1, 0), Sq(1, 1)],
            [Sq(0, 0), Sq(1, 0), Sq(2, 0)],
        ]

        XCTAssertEqual(paths, check)
    }
}
