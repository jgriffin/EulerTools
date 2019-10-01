//
//  BinarySearch.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/11/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

func binarySearch<T: Comparable>(_ a: [T], key: T) -> Int? {
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
