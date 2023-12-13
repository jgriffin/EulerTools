//
// Created by John Griffin on 5/27/23
//

import Foundation

public extension Collection {
    var assertOnly: Element? {
        assert(count <= 1)
        return first
    }
}
