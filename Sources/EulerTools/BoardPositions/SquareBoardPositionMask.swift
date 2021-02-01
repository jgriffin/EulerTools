//
//
// Created by John Griffin on 1/31/21
//

import Foundation

public protocol SquareBoardPosition: Hashable {
    var r: Int { get }
    var c: Int { get }

    static func make(r: Int, c: Int) -> Self
}

public extension SquareBoardPosition {
    // intesection with y-axis
    var forwardDiag: Int { c - r }

    // intesection with y-axis
    var backwardDiag: Int { c + r }

    func nextCol(maxCol: Int) -> Self? {
        guard c < maxCol - 1 else { return nil }
        return .make(r: r, c: c + 1)
    }
}
