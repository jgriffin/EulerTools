//
//
// Created by John Griffin on 1/31/21
//

import Foundation

public extension SquareBoard {
    struct PositionRC: SquareBoardPosition, CustomStringConvertible {
        public let rc: RC

        // MARK: init

        public init(_ rc: RC) {
            self.rc = rc
        }

        public static func make(_ rc: RC) -> PositionRC {
            .init(rc)
        }
    }
}
