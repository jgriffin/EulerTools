//
// Created by John Griffin on 5/27/23
//

import Foundation

public extension Sequence {
    func sorted(
        by keyPath: KeyPath<Element, some Comparable>
    ) -> [Element] {
        sorted(by: areInIncreasingOrder(by: keyPath))
    }

    func sorted(
        by: @escaping (Element, Element) -> Bool,
        then: @escaping (Element, Element) -> Bool
    ) -> [Element] where Element: Comparable {
        sorted(by: areInIncreasingOrder(by: by, then: then))
    }

    func sorted(
        by keyPath: KeyPath<Element, some Comparable>,
        then keyPath2: KeyPath<Element, some Comparable>
    ) -> [Element] where Element: Comparable {
        sorted(by: areInIncreasingOrder(by: keyPath, then: keyPath2))
    }
}

public func areInIncreasingOrder<Element>(
    by keyPath: KeyPath<Element, some Comparable>
) -> (Element, Element) -> Bool {
    { lhs, rhs in
        lhs[keyPath: keyPath] < rhs[keyPath: keyPath]
    }
}

public func areInIncreasingOrder<Element>(
    by: @escaping (Element, Element) -> Bool,
    then: @escaping (Element, Element) -> Bool
) -> (Element, Element) -> Bool {
    { lhs, rhs in
        if by(lhs, rhs) {
            return true
        }
        if by(rhs, lhs) {
            return false
        }
        return then(lhs, rhs)
    }
}

public func areInIncreasingOrder<Element>(
    by byKeyPath: KeyPath<Element, some Comparable>,
    then thenKeyPath: KeyPath<Element, some Comparable>
) -> (Element, Element) -> Bool {
    areInIncreasingOrder(
        by: areInIncreasingOrder(by: byKeyPath),
        then: areInIncreasingOrder(by: thenKeyPath)
    )
}
