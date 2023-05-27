//
// Created by John Griffin on 5/27/23
//

import Foundation

public extension Collection {
    var only: Element? {
        guard count == 1 else { return nil }
        return first
    }
}
