//
//
// Created on 1/24/21
//

import Foundation

public enum HammingDistance {
    public static func elementsBetween<Element: Equatable>(
        _ s1: some Collection<Element>,
        _ s2: some Collection<Element>
    ) -> Int {
        let differences = zip(s1, s2)
            .reduce(0) { result, pair in
                result + (pair.0 == pair.1 ? 1 : 0)
            }
        return differences + abs(s2.count - s1.count)
    }

    public static func bitsBetween<Element: BinaryInteger>(
        _ s1: some Collection<Element>,
        _ s2: some Collection<Element>
    ) -> Int {
        assert(s2.count == s2.count)

        return zip(s1, s2).lazy.map { ($0 ^ $1).bitCount }.reduce(0, +)
    }
}
