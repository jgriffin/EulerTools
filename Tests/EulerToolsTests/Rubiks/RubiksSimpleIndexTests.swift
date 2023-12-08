//
// Created by John Griffin on 12/7/23
//

import EulerTools
import XCTest

final class RubiksSimpleIndexTests: XCTestCase {
    typealias Index = Rubiks.SimpleIndex
    typealias Cubie = Rubiks.SimpleCubie
    let starting = Cubie.starting

    func testRotateRows() {
        let stacked = Index.fronts + .rights + .backs.rotatedNineCW() + .lefts
        let indexMap = stacked.rowsFromNines()[1].indexMapRotate(toStartAt: 3)
        XCTAssertEqual(indexMap.dumpNines, """
        [u0, u1, u2]  [l0, l1, l2]  [f0, f1, f2]  [r0, r1, r2]  [b0, l5, b2]  [d0, d1, d2]
        [u3, u4, u5]  [f3, f4, f5]  [r3, r4, r5]  [b7, b4, b1]  [b3, l4, b5]  [d3, d4, d5]
        [u6, u7, u8]  [l6, l7, l8]  [f6, f7, f8]  [r6, r7, r8]  [b6, l3, b8]  [d6, d7, d8]
        """)
    }

    func testRotateCols() {
        let stacked = Index.fronts + .downs + .backs.rotatedNineCW(2) + .ups
        let indexMap = stacked.colsFromNines()[1].indexMapRotate(toStartAt: -6)
        XCTAssertEqual(indexMap.dumpNines, """
        [u0, d1, u2]  [l0, l1, l2]  [f0, b7, f2]  [r0, r1, r2]  [b0, f7, b2]  [d0, u1, d2]
        [u3, d4, u5]  [l3, l4, l5]  [f3, b4, f5]  [r3, r4, r5]  [b3, f4, b5]  [d3, u4, d5]
        [u6, d7, u8]  [l6, l7, l8]  [f6, b1, f8]  [r6, r7, r8]  [b6, f1, b8]  [d6, u7, d8]
        """)
    }

    func testRotateUpCW() {
        let indexMap = Index.rotateFocusCW(count: 1)
        XCTAssertEqual(indexMap.indexAtMap.count, 9 + 12)
        XCTAssertEqual(indexMap.dumpNines, """
        [u6, u3, u0]  [f0, f1, f2]  [r0, r1, r2]  [b0, b1, b2]  [l0, l1, l2]  [d0, d1, d2]
        [u7, u4, u1]  [l3, l4, l5]  [f3, f4, f5]  [r3, r4, r5]  [b3, b4, b5]  [d3, d4, d5]
        [u8, u5, u2]  [l6, l7, l8]  [f6, f7, f8]  [r6, r7, r8]  [b6, b7, b8]  [d6, d7, d8]
        """)
    }

    // MARK: - rotate to top

    func testFocusF() {
        let indexMap = Index.focus(.f)
        XCTAssertEqual(indexMap.dumpNines, """
        [f0, f1, f2]  [l2, l5, l8]  [d0, d1, d2]  [r6, r3, r0]  [u8, u7, u6]  [b8, b7, b6]
        [f3, f4, f5]  [l1, l4, l7]  [d3, d4, d5]  [r7, r4, r1]  [u5, u4, u3]  [b5, b4, b3]
        [f6, f7, f8]  [l0, l3, l6]  [d6, d7, d8]  [r8, r5, r2]  [u2, u1, u0]  [b2, b1, b0]
        """)
    }

    func testFocusL() {
        let indexMap = Index.focus(.l)
        XCTAssertEqual(indexMap.dumpNines, """
        [l0, l1, l2]  [b2, b5, b8]  [d6, d3, d0]  [f6, f3, f0]  [u6, u3, u0]  [r8, r7, r6]
        [l3, l4, l5]  [b1, b4, b7]  [d7, d4, d1]  [f7, f4, f1]  [u7, u4, u1]  [r5, r4, r3]
        [l6, l7, l8]  [b0, b3, b6]  [d8, d5, d2]  [f8, f5, f2]  [u8, u5, u2]  [r2, r1, r0]
        """)
    }

    func testFocusB() {
        let indexMap = Index.focus(.b)
        XCTAssertEqual(indexMap.dumpNines, """
        [b0, b1, b2]  [r2, r5, r8]  [d8, d7, d6]  [l6, l3, l0]  [u0, u1, u2]  [f8, f7, f6]
        [b3, b4, b5]  [r1, r4, r7]  [d5, d4, d3]  [l7, l4, l1]  [u3, u4, u5]  [f5, f4, f3]
        [b6, b7, b8]  [r0, r3, r6]  [d2, d1, d0]  [l8, l5, l2]  [u6, u7, u8]  [f2, f1, f0]
        """)
    }

    func testFocusR() {
        let indexMap = Index.focus(.r)
        XCTAssertEqual(indexMap.dumpNines, """
        [r0, r1, r2]  [f2, f5, f8]  [d2, d5, d8]  [b6, b3, b0]  [u2, u5, u8]  [l8, l7, l6]
        [r3, r4, r5]  [f1, f4, f7]  [d1, d4, d7]  [b7, b4, b1]  [u1, u4, u7]  [l5, l4, l3]
        [r6, r7, r8]  [f0, f3, f6]  [d0, d3, d6]  [b8, b5, b2]  [u0, u3, u6]  [l2, l1, l0]
        """)
    }

    func testFocusD() {
        let indexMap = Index.focus(.d)
        XCTAssertEqual(indexMap.dumpNines, """
        [d0, d1, d2]  [l8, l7, l6]  [b8, b7, b6]  [r8, r7, r6]  [f8, f7, f6]  [u0, u1, u2]
        [d3, d4, d5]  [l5, l4, l3]  [b5, b4, b3]  [r5, r4, r3]  [f5, f4, f3]  [u3, u4, u5]
        [d6, d7, d8]  [l2, l1, l0]  [b2, b1, b0]  [r2, r1, r0]  [f2, f1, f0]  [u6, u7, u8]
        """)
    }

    // MARK: - rotate face

    func testRotateU() {
        let indexMap = Index.rotateCW(.u, 1)
        XCTAssertEqual(indexMap.dumpNines, """
        [u6, u3, u0]  [f0, f1, f2]  [r0, r1, r2]  [b0, b1, b2]  [l0, l1, l2]  [d0, d1, d2]
        [u7, u4, u1]  [l3, l4, l5]  [f3, f4, f5]  [r3, r4, r5]  [b3, b4, b5]  [d3, d4, d5]
        [u8, u5, u2]  [l6, l7, l8]  [f6, f7, f8]  [r6, r7, r8]  [b6, b7, b8]  [d6, d7, d8]
        """)
    }

    func testRotateF() {
        let indexMap = Index.rotateCW(.f, 1)
        XCTAssertEqual(indexMap.dumpNines, """
        [u0, u1, u2]  [l0, l1, d0]  [f6, f3, f0]  [u6, r1, r2]  [b0, b1, b2]  [r6, r3, r0]
        [u3, u4, u5]  [l3, l4, d1]  [f7, f4, f1]  [u7, r4, r5]  [b3, b4, b5]  [d3, d4, d5]
        [l8, l5, l2]  [l6, l7, d2]  [f8, f5, f2]  [u8, r7, r8]  [b6, b7, b8]  [d6, d7, d8]
        """)
    }

    func testRotateL() {
        let indexMap = Index.rotateCW(.l, 1)
        XCTAssertEqual(indexMap.dumpNines, """
        [b8, u1, u2]  [l6, l3, l0]  [u0, f1, f2]  [r0, r1, r2]  [b0, b1, d6]  [f0, d1, d2]
        [b5, u4, u5]  [l7, l4, l1]  [u3, f4, f5]  [r3, r4, r5]  [b3, b4, d3]  [f3, d4, d5]
        [b2, u7, u8]  [l8, l5, l2]  [u6, f7, f8]  [r6, r7, r8]  [b6, b7, d0]  [f6, d7, d8]
        """)
    }

    func testRotateB() {
        let indexMap = Index.rotateCW(.b, 1)
        XCTAssertEqual(indexMap.dumpNines, """
        [r2, r5, r8]  [u2, l1, l2]  [f0, f1, f2]  [r0, r1, d8]  [b6, b3, b0]  [d0, d1, d2]
        [u3, u4, u5]  [u1, l4, l5]  [f3, f4, f5]  [r3, r4, d7]  [b7, b4, b1]  [d3, d4, d5]
        [u6, u7, u8]  [u0, l7, l8]  [f6, f7, f8]  [r6, r7, d6]  [b8, b5, b2]  [l0, l3, l6]
        """)
    }

    func testRotateR() {
        let indexMap = Index.rotateCW(.r, 1)
        XCTAssertEqual(indexMap.dumpNines, """
        [u0, u1, f2]  [l0, l1, l2]  [f0, f1, d2]  [r6, r3, r0]  [u8, b1, b2]  [d0, d1, b6]
        [u3, u4, f5]  [l3, l4, l5]  [f3, f4, d5]  [r7, r4, r1]  [u5, b4, b5]  [d3, d4, b3]
        [u6, u7, f8]  [l6, l7, l8]  [f6, f7, d8]  [r8, r5, r2]  [u2, b7, b8]  [d6, d7, b0]
        """)
    }

    func testRotateD() {
        let indexMap = Index.rotateCW(.d, 1)
        XCTAssertEqual(indexMap.dumpNines, """
        [u0, u1, u2]  [l0, l1, l2]  [f0, f1, f2]  [r0, r1, r2]  [b0, b1, b2]  [d6, d3, d0]
        [u3, u4, u5]  [l3, l4, l5]  [f3, f4, f5]  [r3, r4, r5]  [b3, b4, b5]  [d7, d4, d1]
        [u6, u7, u8]  [b6, b7, b8]  [l6, l7, l8]  [f6, f7, f8]  [r6, r7, r8]  [d8, d5, d2]
        """)
    }
}
