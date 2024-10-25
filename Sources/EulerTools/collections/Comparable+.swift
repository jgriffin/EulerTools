//
// Created by John Griffin on 11/18/23
//

public extension Sequence {
    func sorted(
        by keyPath: KeyPath<Element, some Comparable>
    ) -> [Element] {
        sorted(by: keyPath.areInOrder)
    }

    func sorted(
        by keyPath: KeyPath<Element, some Comparable>,
        then keyPath2: KeyPath<Element, some Comparable>
    ) -> [Element] {
        sorted(by: areInOrder(by: keyPath.areInOrder, keyPath2.areInOrder))
    }

    func sorted(
        by keyPath: KeyPath<Element, some Comparable>,
        thenDesc keyPath2: KeyPath<Element, some Comparable>
    ) -> [Element] {
        sorted(by: areInOrder(by: keyPath.areInOrder, keyPath2.areInDescOrder))
    }
}

public extension KeyPath where Value: Comparable {
    var areInOrder: (Root, Root) -> Bool {
        { lhs, rhs in
            lhs[keyPath: self] < rhs[keyPath: self]
        }
    }

    var areInDescOrder: (Root, Root) -> Bool {
        { lhs, rhs in
            lhs[keyPath: self] > rhs[keyPath: self]
        }
    }
}

public func areInOrder<Element>(
    by subsorts: ((Element, Element) -> Bool)...
) -> (Element, Element) -> Bool {
    { lhs, rhs in
        for subsort in subsorts {
            if subsort(lhs, rhs) {
                return true
            }
            if subsort(rhs, lhs) {
                return false
            }
        }
        return true
    }
}

/**
 simple way to sort between two array with the first element that doesn't match
 */
public func isSequenceOrderedBefore<Element: Comparable>(
    _ lhs: some Sequence<Element>,
    _ rhs: some Sequence<Element>
) -> Bool {
    for (l, r) in zip(lhs, rhs) {
        guard l != r else { continue }
        return l < r
    }
    return true
}
