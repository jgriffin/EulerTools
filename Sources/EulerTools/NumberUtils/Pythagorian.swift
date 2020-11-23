//
//  PythagorianTripples.swift
//
//
//  Created by John Griffin on 2/28/20.
//

import Foundation

public struct Pythagorian {
    public struct Tripple: Hashable {
        public let a, b, c: Int

        // order a, b c
        public static func isBeforeABC(lhs: Pythagorian.Tripple, rhs: Pythagorian.Tripple) -> Bool {
            if lhs.a < rhs.a { return true }
            guard lhs.a == rhs.a else { return false }

            if lhs.b < rhs.b { return true }
            guard lhs.b == rhs.b else { return false }

            return lhs.c < rhs.c
        }

        public static func isBeforeCBA(lhs: Pythagorian.Tripple, rhs: Pythagorian.Tripple) -> Bool {
            if lhs.c < rhs.c { return true }
            guard lhs.c == rhs.c else { return false }

            if lhs.b < rhs.b { return true }
            guard lhs.b == rhs.b else { return false }

            return lhs.a < rhs.a
        }
    }

    // returns all primitive and non-primitive tripples with c < cMax
    // note: the results are not necessarily sorted
    public static func primitiveTripples(upThroughSideMax sideMax: Int?, cMax: Int?) -> [Tripple] {
        assert(sideMax != nil || cMax != nil)

        var tripples = [Tripple]()

        let mMax = sideMax ?? cMax!

        for m in stride(from: 1, through: mMax, by: 2) {
            for n in stride(from: 1, to: m, by: 2) {
                guard GCD(m, n) == 1 else {
                    continue
                }

                let a = m * n
                let b = (m * m - n * n) / 2
                let c = (m * m + n * n) / 2

                guard sideMax.flatMap({ a <= $0 }) ?? true,
                    cMax.flatMap({ c <= $0 }) ?? true
                else {
                    break
                }

                guard sideMax.flatMap({ b <= $0 }) ?? true else {
                    continue
                }

                tripples.append(Tripple(a: min(a, b), b: max(a, b), c: c))
            }
        }

        return tripples
    }

    // returns all primitive and non-primitive tripples with c < cMax
    // note: the results are not necessarily sorted
    public static func allTripples(upThroughSideMax sideMax: Int?, cMax: Int?) -> [Tripple] {
        assert(sideMax != nil || cMax != nil)

        var tripples = primitiveTripples(upThroughSideMax: sideMax, cMax: cMax)

        for primitive in tripples {
            var k = 2
            while true {
                guard sideMax.flatMap({ k * primitive.b <= $0 }) ?? true,
                    cMax.flatMap({ k * primitive.c <= $0 }) ?? true
                else {
                    break
                }
                tripples.append(Tripple(a: k * primitive.a,
                                        b: k * primitive.b,
                                        c: k * primitive.c))
                k += 1
            }
        }

        return tripples
    }
}
