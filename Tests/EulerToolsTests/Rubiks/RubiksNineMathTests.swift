//
// Created by John Griffin on 12/7/23
//

import EulerTools
import XCTest

final class RubiksNineMathTests: XCTestCase {
    typealias Index = Rubiks.SimpleIndex
    typealias Cubie = Rubiks.SimpleCubie
    let starting = Cubie.starting

    func testRotateNine() {
        let result = (0 ... 8).asArray.rotatedNineCW()
        XCTAssertEqual(result.dumpNines, """
        [6, 3, 0]
        [7, 4, 1]
        [8, 5, 2]
        """)
    }

    func testRotateNine2() {
        let result = (0 ... 8).asArray.rotatedNineCW(2)
        XCTAssertEqual(result.dumpNines, """
        [8, 7, 6]
        [5, 4, 3]
        [2, 1, 0]
        """)
    }

    func testFlipNineH() {
        let result = (0 ... 8).asArray.flipNineH()
        XCTAssertEqual(result.dumpNines, """
        [2, 1, 0]
        [5, 4, 3]
        [6, 7, 6]
        """)
    }

    func testFlipNineV() {
        let result = (0 ... 8).asArray.flipNineV()
        XCTAssertEqual(result.dumpNines, """
        [6, 7, 8]
        [3, 4, 5]
        [0, 1, 2]
        """)
    }
}
