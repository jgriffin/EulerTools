//
// Created by John Griffin on 12/8/23
//

import Foundation

public extension Array {
    func rotatedNineCW(_ count: Int = 1) -> [Element] {
        assert(self.count == 9)
        let indexAt = [0, 1, 2, 5, 8, 7, 6, 3]
        let put = indexAt.rotated(toStartAt: -2 * count)

        var copy = self
        for (at, put) in zip(indexAt, put) {
            copy[at] = self[put]
        }
        return copy
    }

    func flipNineH() -> [Element] {
        assert(count == 9)
        var copy = self
        for (at, put) in zip([0, 3, 5, 2, 5, 8], [2, 5, 8, 0, 3, 6]) {
            copy[at] = self[put]
        }
        return copy
    }

    func flipNineV() -> [Element] {
        assert(count == 9)
        var copy = self
        for (at, put) in zip([0, 1, 2, 6, 7, 8], [6, 7, 8, 0, 1, 2]) {
            copy[at] = self[put]
        }
        return copy
    }

    /// assuming up is up
    func rowsFromNines() -> [[Element]] {
        [self[...], self[3...], self[6...]].map {
            $0.chunks(ofCount: 9).flatMap { $0.prefix(3) }
        }
    }

    /// assuming up is up
    func colsFromNines() -> [[Element]] {
        [
            striding(by: 3).asArray,
            dropFirst(1).striding(by: 3).asArray,
            dropFirst(2).striding(by: 3).asArray,
        ]
    }

    var dumpNines: NSString {
        rowsFromNines().map {
            $0.chunks(ofCount: 3).map(\.description).joined(separator: "  ")
        }.joinedByNewlines as NSString
    }
}

public extension Collection {
    func rotated(toStartAt: Int) -> [Element] {
        let toStartAt = toStartAt < 0 ? toStartAt + count : toStartAt
        var copy = asArray
        copy.rotate(toStartAt: toStartAt)
        return copy
    }

    func stripsRotated(toStartAt: Int) -> [[Element.Element]] where Element: Collection {
        map {
            $0.rotated(toStartAt: toStartAt)
        }
    }
}
