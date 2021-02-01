//
//
// Created by John Griffin on 1/31/21
//

import Foundation

public protocol SquareBoardPosition: Hashable, Comparable, CustomStringConvertible {
    var r: Int { get }
    var c: Int { get }

    static func make(r: Int, c: Int) -> Self
}

public extension SquareBoardPosition {
    var description: String {
        "(\(r),\(c))"
    }

    static func < (_ lhs: Self, _ rhs: Self) -> Bool {
        if lhs.r < rhs.r {
            return true
        } else if lhs.r > rhs.r {
            return false
        }

        return lhs.c < rhs.c
    }

    func move(dr: Int, dc: Int, maxR: Int, maxC: Int) -> Self? {
        let (nextR, nextC) = (r + dr, c + dc)

        guard (0 ..< maxR).contains(nextR),
              (0 ..< maxC).contains(nextC)
        else {
            return nil
        }
        return Self.make(r: nextR, c: nextC)
    }
}

public extension SquareBoardPosition {
    // intesection with y-axis
    var forwardDiag: Int { c - r }

    // intesection with y-axis
    var backwardDiag: Int { c + r }
}

public extension SquareBoardPosition {
    static func walk(from start: Self,
                     stepR: Int,
                     stepC: Int,
                     maxR: Int,
                     maxC: Int) -> Set<Self>
    {
        var cur = start
        var path = Set([cur])

        while let next = cur.move(dr: stepR, dc: stepC,
                                  maxR: maxR, maxC: maxC)
        {
            path.insert(next)
            cur = next
        }

        return path
    }

    func forwardDiagonals(maxR: Int, maxC: Int) -> Set<Self> {
        let fDiag = forwardDiag
        let start = fDiag > 0 ?
            Self.make(r: 0, c: fDiag) :
            Self.make(r: -fDiag, c: 0)

        return Self.walk(from: start,
                         stepR: 1, stepC: 1,
                         maxR: maxR, maxC: maxC)
    }

    func backwardDiagonals(maxR: Int, maxC: Int) -> Set<Self> {
        let bDiag = backwardDiag

        let start = bDiag < maxC ?
            Self.make(r: 0, c: bDiag) :
            Self.make(r: bDiag - (maxC - 1), c: maxC - 1)

        return Self.walk(from: start,
                         stepR: 1, stepC: -1,
                         maxR: maxR, maxC: maxC)
    }

    func diagonals(maxR: Int, maxC: Int) -> Set<Self> {
        forwardDiagonals(maxR: maxR, maxC: maxC)
            .union(backwardDiagonals(maxR: maxR, maxC: maxC))
    }
}
