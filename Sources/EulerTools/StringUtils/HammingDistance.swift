//
//
// Created on 1/24/21
//

import Foundation

public enum StringUtils {}

public extension StringUtils {
    static func hammingDistance<C: Collection>(_ s1: C,
                                               _ s2: C) -> Int
        where C.Element: Equatable
    {
        let differentCount = zip(s1, s2)
            .reduce(0) { result, pair in
                pair.0 == pair.1 ? result : result + 1
            }
        return differentCount + abs(s2.count - s1.count)
    }
}
