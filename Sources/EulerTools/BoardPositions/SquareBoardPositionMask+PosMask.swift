//
//
// Created by John Griffin on 2/1/21
//

public extension SquareBoardPositionMask {
    static func positionsFromMask(_ mask: PosMask) -> [Self] {
        mask.individualBits.map(Self.make)
    }

    static func maskFromPositions<S: Sequence>(_ positions: S) -> PosMask
        where S.Element == Self
    {
        positions.map(\.mask).reduce(PosMask(0), |)
    }

    static func maskFromRCs<S: Sequence>(_ rcs: S) -> PosMask
        where S.Element == RC
    {
        rcs.map(Self.maskFrom).reduce(PosMask(0), |)
    }
}
