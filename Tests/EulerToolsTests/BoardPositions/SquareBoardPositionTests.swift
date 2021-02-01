//
//
// Created by John Griffin on 1/31/21
//

import Algorithms
import EulerTools
import XCTest

final class SquareBoardPositionsTests: XCTestCase {
    typealias RC = SquareBoard.RC
    typealias PositionRC = SquareBoard.PositionRC
    typealias PositionMask8 = SquareBoard.PositionMask8
    typealias PositionMask4 = SquareBoard.PositionMask4

    func testPositionRC() {
        product(0 ..< 8, 0 ..< 8)
            .forEach { r, c in
                let p = PositionRC.make(.init(r, c))
                XCTAssertEqual(p.r, r)
                XCTAssertEqual(p.c, c)
            }
    }

    func testPositionMask8RC() {
        product(0 ..< 8, 0 ..< 8)
            .forEach { r, c in
                let p = PositionMask8.make(.init(r, c))
                XCTAssertEqual(p.r, r)
                XCTAssertEqual(p.c, c)
            }
    }

    func testPositionMask4RC() {
        product(0 ..< 4, 0 ..< 4)
            .forEach { r, c in
                let p = PositionMask4.make(.init(r, c))
                XCTAssertEqual(p.r, r)
                XCTAssertEqual(p.c, c)
            }
    }

    func testForwardDiagonals() {
        let n = 4

        let counts = product(0 ..< n, 0 ..< n)
            .map { r, c -> Int in
                let p = PositionMask4.make(.init(r, c))
                let fDiags = p.forwardDiagonals(maxRC: RC(4, 4)).sorted()
                // print(p, fDiags)
                return fDiags.count
            }

        XCTAssertEqual(counts, [4, 3, 2, 1, 3, 4, 3, 2, 2, 3, 4, 3, 1, 2, 3, 4])
    }

    func testBackwardDiagonals() {
        let n = 4

        let counts = product(0 ..< n, 0 ..< n)
            .map { r, c -> Int in
                let p = PositionMask4.make(.init(r, c))

                let bDiags = p.backwardDiagonals(maxRC: RC(n, n)).sorted()
                // print(p, bDiags)
                return bDiags.count
            }

        XCTAssertEqual(counts, [1, 2, 3, 4, 2, 3, 4, 3, 3, 4, 3, 2, 4, 3, 2, 1])
    }

    func testDiagonals() {
        let n = 4

        let counts = product(0 ..< n, 0 ..< n)
            .map { r, c -> Int in
                let p = PositionMask4.make(.init(r, c))

                let diags = p.diagonals(maxRC: RC(n, n)).sorted()
                // print(p, diags)
                return diags.count
            }

        XCTAssertEqual(counts, [4, 4, 4, 4, 4, 6, 6, 4, 4, 6, 6, 4, 4, 4, 4, 4])
    }
}
