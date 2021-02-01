//
//
// Created by John Griffin on 1/31/21
//

import Foundation

public extension SquareBoard {
    struct PositionRC: SquareBoardPosition {
        public let r, c: Int

        // MARK: init

        public init(r: Int, c: Int) {
            self.r = r
            self.c = c
        }

        public static func make(r: Int, c: Int) -> PositionRC {
            .init(r: r, c: c)
        }
    }
}
