//
//  BinarySearch.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/11/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Algorithms
import Foundation

public extension RandomAccessCollection {
    /// Finds index where e exists or would be inserted
    func binarySearchIndex(for e: Element) -> Index where Element: Comparable {
        partitioningIndex(where: { $0 >= e })
    }

    /// Finds element at the index where e exists or would go
    func binarySearchValidIndex(for e: Element) -> Index? where Element: Comparable {
        let index = binarySearchIndex(for: e)
        return indices.contains(index) ? index : nil
    }

    /// Finds index where e exists or nil
    func binarySearchIndex(ifExists e: Element) -> Index? where Element: Comparable {
        guard let index = binarySearchValidIndex(for: e),
              self[index] == e
        else {
            return nil
        }
        return index
    }

    /// Finds element at the index where e exists or would go
    func binarySearchValidIndex(forOrBefore e: Element) -> Index? where Element: Comparable {
        guard let index = binarySearchValidIndex(for: e) else { return nil }
        guard self[index] != e else { return index }
        return index > startIndex ? self.index(before: index) : nil
    }
}
