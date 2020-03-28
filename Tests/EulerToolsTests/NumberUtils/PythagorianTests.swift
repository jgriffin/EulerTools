//
//  PythagorianTripplesTests.swift
//
//
//  Created by John Griffin on 2/28/20.
//

import EulerTools
import XCTest

class PythagorianTests: XCTestCase {
    func testPrimitiveTripplesUnder100() {
        let tripples = Pythagorian.primitiveTripples(upThroughSideMax: nil, cMax: 100)
        XCTAssertEqual(tripples.count, 16)
    }

    func testPrimitiveTripplesUnder300() {
        let tripples = Pythagorian.primitiveTripples(upThroughSideMax: nil, cMax: 300)
        XCTAssertEqual(tripples.count, 16 + 31)

        // a,b,c are in increasing order
        tripples.forEach { tripple in
            XCTAssertTrue(tripple.a < tripple.b && tripple.b < tripple.c)
        }

        // and unique
        XCTAssertEqual(Set(tripples).count, tripples.count)

        // might be out of order
        var outOfOrderCount = 0
        zip(tripples, tripples.dropFirst()).forEach { first, second in
            guard first.c < second.c else {
                outOfOrderCount += 1
                return
            }
        }
        XCTAssertEqual(outOfOrderCount, 7)

        // and c's may not be unique
        let cs = tripples.map { $0.c }
        XCTAssertEqual(cs.count - Set(cs).count, 7)
    }

    func testAllPrimitiveTripplesUnder300() {
        let tripples = Pythagorian.allTripples(upThroughSideMax: nil, cMax: 300)
        XCTAssertEqual(tripples.count, 209)

        // a,b,c are in increasing order
        tripples.forEach { tripple in
            XCTAssertTrue(tripple.a < tripple.b && tripple.b < tripple.c)
        }

        // and unique
        XCTAssertEqual(Set(tripples).count, tripples.count)
    }
}
