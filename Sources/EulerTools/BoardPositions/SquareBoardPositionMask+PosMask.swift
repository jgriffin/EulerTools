//
//
// Created by John Griffin on 2/1/21
//

public extension SquareBoardPositionMask {
    static func positionsFromMask(_ mask: PosMask) -> [Self] {
        mask.individualBits.map(make)
    }

    static func maskFromPositions(_ positions: some Sequence<Self>) -> PosMask {
        positions.map(\.mask).reduce(PosMask(0), |)
    }

    static func maskFromRCs(_ rcs: some Sequence<RC>) -> PosMask {
        rcs.map(maskFrom).reduce(PosMask(0), |)
    }
}
