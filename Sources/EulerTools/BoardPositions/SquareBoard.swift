//
//
// Created by John Griffin on 1/31/21
//

// namespace for chessboard like stuff
public enum SquareBoard {}

public extension SquareBoard {
    struct RC: Hashable, Sendable {
        public let r, c: Int

        public init(r: Int, c: Int) {
            self.r = r
            self.c = c
        }

        public init(_ r: Int, _ c: Int) {
            self.init(r: r, c: c)
        }

        public static func + (_ lhs: RC, _ rhs: RC) -> RC {
            .init(lhs.r + rhs.r, lhs.c + rhs.c)
        }

        public func isValid(maxRC: RC) -> Bool {
            (0 ..< maxRC.r).contains(r) &&
                (0 ..< maxRC.c).contains(c)
        }

        public static let squareStepOffsets: [RC] = [
            RC(1, 0), RC(0, -1), RC(0, 1), RC(-1, 0),
        ]

        public static let cornerStepOffsets: [RC] = [
            RC(-1, -1), RC(1, 1), RC(1, -1), RC(1, 1),
        ]

        public static let adjacentStepOffsets: [RC] = squareStepOffsets + cornerStepOffsets
    }
}
