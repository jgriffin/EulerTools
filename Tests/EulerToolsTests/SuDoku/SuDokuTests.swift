//
//  SuDokuTests.swift
//  ProjectEulerTests
//
//  Created by John Griffin on 5/11/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import EulerTools
import XCTest

class SuDokuTests: XCTestCase {
    typealias DigitMask = SuDoku.DigitMask

    func testSuDokuTiles() {
        let zero = DigitMask(number: 0)
        XCTAssertEqual(zero.rawValue, 0b00_0000_0000)
        XCTAssertNil(zero.singleDigit)

        let nine = DigitMask(number: 9)
        XCTAssertEqual(nine.rawValue, 0b1_0000_0000)
        XCTAssertEqual(nine.singleDigit, 9)

        let seven = DigitMask(number: 7)
        XCTAssertEqual(seven.rawValue, 0b0_0100_0000)
        XCTAssertEqual(seven.singleDigit, 7)

        let nineAndSeven = nine.union(seven)
        XCTAssertEqual(nineAndSeven.rawValue, 0b1_0100_0000)
        XCTAssertNil(zero.singleDigit)
    }

    func testSuDokuGridUpdate() {
        let emptyGrid = SuDoku.BoardMasks()
        XCTAssertEqual(emptyGrid.rowMasks.count, 9)
        XCTAssertEqual(emptyGrid.colMasks.count, 9)
        XCTAssertEqual(emptyGrid.squareMasks.count, 9)

        for index in 0 ..< 9 * 9 {
            var grid = SuDoku.BoardMasks()
            grid.updateMasks(index: index, subtracting: DigitMask(number: 1))

            let (r, c, sq) = SuDoku.BoardMasks.maskIndices(for: index)
            XCTAssertEqual(grid.availableMask(for: index).rawValue, 0b1_1111_1110)
            XCTAssertEqual(grid.rowMasks[r].rawValue, 0b1_1111_1110)
            XCTAssertEqual(grid.colMasks[c].rawValue, 0b1_1111_1110)
            XCTAssertEqual(grid.squareMasks[sq].rawValue, 0b1_1111_1110)

            grid.updateMasks(index: index, subtracting: DigitMask(number: 2))
            XCTAssertEqual(grid.availableMask(for: index).rawValue, 0b1_1111_1100)
            XCTAssertEqual(grid.rowMasks[r].rawValue, 0b1_1111_1100)
            XCTAssertEqual(grid.colMasks[c].rawValue, 0b1_1111_1100)
            XCTAssertEqual(grid.squareMasks[sq].rawValue, 0b1_1111_1100)
        }
    }

    func testSuDokuGridSquareIndex() {
        let check: [Int] = [
            0, 0, 0, 1, 1, 1, 2, 2, 2,
            0, 0, 0, 1, 1, 1, 2, 2, 2,
            0, 0, 0, 1, 1, 1, 2, 2, 2,
            3, 3, 3, 4, 4, 4, 5, 5, 5,
            3, 3, 3, 4, 4, 4, 5, 5, 5,
            3, 3, 3, 4, 4, 4, 5, 5, 5,
            6, 6, 6, 7, 7, 7, 8, 8, 8,
            6, 6, 6, 7, 7, 7, 8, 8, 8,
            6, 6, 6, 7, 7, 7, 8, 8, 8,
        ]
        let squareIndices = (0 ... 80).map { SuDoku.BoardMasks.maskIndices(for: $0).sq }
        XCTAssertEqual(squareIndices, check)
    }
}
