//
//  ChineseRemainderTests.swift
//
//
//  Created by Griff on 1/3/21.
//

import EulerTools
import XCTest

final class ChineseReminderTests: XCTestCase {
    func testChineseRemainderTheorem1() {
        let amis: [(ai: Int, mi: Int)] = [
            (1, 5),
            (2, 7),
            (3, 9),
            (4, 11),
        ]

        let result = Int.chineseRemainderTheorem(amis)
        XCTAssertEqual(result, 1731)
    }

    func testChineseRemainderTheorem2() {
        let amis: [(ai: Int, mi: Int)] = [
            (2, 3),
            (3, 4),
            (1, 5),
        ]

        let result = Int.chineseRemainderTheorem(amis)
        XCTAssertEqual(result, 11)
    }

    func testChineseRemainderTheorem3() {
        let amis: [(ai: Int, mi: Int)] = [
            (1, 3),
            (4, 5),
            (6, 7),
        ]

        let result = Int.chineseRemainderTheorem(amis)
        XCTAssertEqual(result, 34)
    }

    func testChineseRemainderTheorem4() {
        let amis: [(ai: Int, mi: Int)] = [
            (3, 5),
            (3, 6),
            (1, 7),
            (0, 11),
        ]

        let result = Int.chineseRemainderTheorem(amis)
        XCTAssertEqual(result, 1023)
    }
}
