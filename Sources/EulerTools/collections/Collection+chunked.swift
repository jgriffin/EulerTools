//
//  Created by John Griffin on 3/14/20.
//

import Foundation

public extension Collection where Index == Int {
    func chunked(by size: Int) -> [SubSequence] {
        stride(from: startIndex, to: endIndex, by: size).map { index in
            let end = self.index(index, offsetBy: size, limitedBy: self.endIndex) ?? endIndex

            return self[index ..< end]
        }
    }
}

public extension StringProtocol {
    func chunked(by size: Int) -> [SubSequence] {
        var chunks: [SubSequence] = []

        var i = startIndex

        while let nextIndex = index(i, offsetBy: size, limitedBy: endIndex) {
            chunks.append(self[i ..< nextIndex])
            i = nextIndex
        }

        let finalChunk = self[i ..< endIndex]

        if finalChunk.isEmpty == false {
            chunks.append(finalChunk)
        }

        return chunks
    }
}
