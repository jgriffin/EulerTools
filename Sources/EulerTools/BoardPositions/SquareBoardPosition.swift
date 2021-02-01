//
//
// Created by John Griffin on 1/31/21
//

import Foundation

public protocol SquareBoardPosition: Hashable, Comparable, CustomStringConvertible {
    typealias RC = SquareBoard.RC

    var rc: RC { get }

    static func make(_ rc: RC) -> Self
}

public extension SquareBoardPosition {
    var r: Int { rc.r }
    var c: Int { rc.c }

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

    func move(drc: RC, maxRC: RC) -> Self? {
        let next = rc + drc
        guard next.isValid(maxRC: maxRC) else {
            return nil
        }
        return Self.make(next)
    }
}

public extension SquareBoardPosition {
    // intesection with y-axis
    var forwardDiag: Int { c - r }

    // intesection with y-axis
    var backwardDiag: Int { c + r }
}

public extension SquareBoardPosition {
    func walk(stepRC: RC, maxRC: RC) -> Set<Self> {
        var cur = self
        var path = Set([cur])

        while let next = cur.move(drc: stepRC, maxRC: maxRC) {
            path.insert(next)
            cur = next
        }

        return path
    }

    func forwardDiagonals(maxRC: RC) -> Set<Self> {
        let fDiag = forwardDiag
        let start = fDiag > 0 ?
            Self.make(RC(0, fDiag)) :
            Self.make(RC(-fDiag, 0))

        return start.walk(stepRC: RC(1, 1),
                          maxRC: maxRC)
    }

    func backwardDiagonals(maxRC: RC) -> Set<Self> {
        let bDiag = backwardDiag

        let start = bDiag < maxRC.c ?
            Self.make(RC(0, bDiag)) :
            Self.make(RC(bDiag - (maxRC.c - 1), maxRC.c - 1))

        return start.walk(stepRC: RC(1, -1),
                          maxRC: maxRC)
    }

    func diagonals(maxRC: RC) -> Set<Self> {
        forwardDiagonals(maxRC: maxRC)
            .union(backwardDiagonals(maxRC: maxRC))
    }

    func adjacent(maxRC: RC) -> Set<Self> {
        Set(
            RC.adjacentStepOffsets
                .compactMap { drc in
                    move(drc: drc, maxRC: maxRC)
                }
        )
    }
}
