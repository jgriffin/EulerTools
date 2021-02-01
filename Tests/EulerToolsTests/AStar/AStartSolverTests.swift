//
//
// Created by John Griffin on 1/31/21
//

import EulerTools
import XCTest

final class AStartSolverTests: XCTestCase {
    typealias RC = SquareBoard.RC
    typealias Pos4 = SquareBoard.PositionMask4

    func testAStarSolverTrival() {
        let start = 0
        let goal = 10

        let hScorer = { s in abs(goal - s) }
        let neighborGenerator = { s in
            [s - 1, s + 1]
                .filter { (start ... goal).contains($0) }
        }

        let solver = AStarSolver(hScorer: hScorer,
                                 neighborGenerator: neighborGenerator)

        let solution = solver.solve(from: start,
                                    goal: goal)

        XCTAssertEqual(solution, Array((0 ... 10).reversed()))
    }

    func testAStarSolver2d() {
        let maxRC = Pos4.RC(4, 4)
        let start = Pos4.make(.init(0, 0))
        let goal = Pos4.make(.init(3, 3))

        let hScorer = { (s: Pos4) in abs(goal.r - s.r) + abs(goal.c - s.c) }
        let neighborGenerator = { (s: Pos4) in
            s.adjacent(maxRC: maxRC)
        }

        let solver = AStarSolver(hScorer: hScorer,
                                 neighborGenerator: neighborGenerator)

        let solution = solver.solve(from: start,
                                    goal: goal)

        XCTAssertEqual(
            solution,
            [RC(3, 3), RC(2, 2), RC(1, 1), RC(0, 0)].map(Pos4.make)
        )
    }
}
