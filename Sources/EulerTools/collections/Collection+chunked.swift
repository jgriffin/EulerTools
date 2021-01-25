//
//  Created by John Griffin on 3/14/20.
//

import Foundation

public extension Collection {
    func chunked(by chunkSize: Int) -> [SubSequence] where Index == Int {
        stride(from: startIndex, to: endIndex, by: chunkSize)
            .map {
                let last = Swift.min($0 + chunkSize, self.count)
                return self[$0 ..< last]
            }
    }
}
