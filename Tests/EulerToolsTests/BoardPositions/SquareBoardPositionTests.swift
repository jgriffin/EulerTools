//
//
// Created by John Griffin on 1/31/21
//

import Algorithms
import EulerTools
import XCTest

final class SquareBoardPositionsTests: XCTestCase {
    typealias PositionRC = SquareBoard.PositionRC
    typealias PositionMask8 = SquareBoard.PositionMask8
    typealias PositionMask4 = SquareBoard.PositionMask4

    func testPositionRC() {
        product(0 ..< 8, 0 ..< 8)
            .forEach { r, c in
                let p = PositionRC.make(r: r, c: c)
                XCTAssertEqual(p.r, r)
                XCTAssertEqual(p.c, c)
            }
    }

    func testPositionMask8RC() {
        product(0 ..< 8, 0 ..< 8)
            .forEach { r, c in
                let p = PositionMask8.make(r: r, c: c)
                XCTAssertEqual(p.r, r)
                XCTAssertEqual(p.c, c)
            }
    }

    func testPositionMask4RC() {
        product(0 ..< 4, 0 ..< 4)
            .forEach { r, c in
                let p = PositionMask4.make(r: r, c: c)
                XCTAssertEqual(p.r, r)
                XCTAssertEqual(p.c, c)
            }
    }
}
