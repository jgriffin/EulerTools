//
//  BinarySearch.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/11/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

extension RandomAccessCollection {
    /// Finds index where e exists or would be inserted
    public func binarySearch<E: Comparable>(indexFor e: E) -> Index? where E == Element {
        binarySearch(predicate: { $0 < e })
    }

    /// Finds index where e exists or nil
    public func binarySearch<E: Comparable>(equal e: E) -> Index? where E == Element {
        guard let index = binarySearch(predicate: { $0 < e }),
            self[index] == e
        else {
            return nil
        }
        return index
    }

    /// Finds index that predicate is true for all elements up to but not including the index N,
    /// and is false for all elements starting with index N.
    /// returns nil if insertion point would be at endIndex, which isn't usable index
    public func binarySearch(predicate: (Element) -> Bool) -> Index? {
        var low = startIndex
        var high = endIndex
        while low != high {
            let mid = index(low, offsetBy: distance(from: low, to: high) / 2)
            if predicate(self[mid]) {
                low = index(after: mid)
            } else {
                high = mid
            }
        }

        guard low != endIndex else {
            return nil
        }

        return low
    }
}

// extension Array where Element: Comparable {
//    // find index where value <= a
//    public func binarySearch(_ key: Element) -> Int?  {
//        return EulerTools.binarySearch(self, key: key)
//    }
// }

// find index where value <= a
public func binarySearch<T: Comparable>(_ a: [T], key: T) -> Int? {
    var (startIndex, endIndex) = (0, a.count)

    while startIndex < endIndex {
        // Find the middle point in the array within the given range
        let midIndex = startIndex + (endIndex - startIndex) / 2

        if a[midIndex] == key {
            // If we found our search key, return the index
            return midIndex
        } else if a[midIndex] < key {
            // If the mdidle value is less than the key, look at the right half
            startIndex = midIndex + 1
        } else {
            // If the midle value is greater than the key, look at the left half
            endIndex = midIndex
        }
    }
    return nil
}
