//
//  Combinations.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/31/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

// implementation of python.itertools combinations
// borrowed from https://github.com/mpangburn/IteratorTools/blob/master/Sources/Combinations.swift

public extension Sequence {
    /**
     Returns an array containing the combinations of the specified length of elements in the sequence.
     ```
     let values = [1, 2, 3, 4].combinations(length: 2, repeatingElements: false)
     // [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]
     let values = [1, 2, 3, 4].combinations(length: 2, repeatingElements: true)
     // [[1, 1], [1, 2], [1, 3], [1, 4], [2, 2], [2, 3], [2, 4], [3, 3], [3, 4]]
     ```
     - Parameters:
     - length: The length of the combinations to return.
     - repeatingElements: A boolean value determining whether or not elements can repeat in a combination.
     - Returns: An array containing the combinations of the specified length of elements in the sequence.
     */
    func combinations(length: Int) -> [[Iterator.Element]] {
        return Array(Combinations(sequence: self,
                                  length: length,
                                  repeatingElements: false))
    }

    func combinationsWithRepeatingElements(length: Int) -> [[Iterator.Element]] {
        return Array(Combinations(sequence: self, length: length, repeatingElements: true))
    }
}

public extension LazySequenceProtocol {
    /**
     Returns an iterator-sequence that returns the combinations of the specified length of elements in the sequence.
     ```
     let values = [1, 2, 3, 4].lazy.combinations(length: 2, repeatingElements: false)
     // [1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]
     let values = [1, 2, 3, 4].lazy.combinations(length: 2, repeatingElements: true)
     // [1, 1], [1, 2], [1, 3], [1, 4], [2, 2], [2, 3], [2, 4], [3, 3], [3, 4]
     ```
     - Parameters:
     - length: The length of the combinations to return.
     - repeatingElements: A boolean value determining whether or not elements can repeat in a combination.
     - Returns: An an iterator-sequence that returns the combinations of the specified length of elements in the sequence.
     */
    func combinations(length: Int) -> Combinations<Self> {
        return Combinations(sequence: self, length: length, repeatingElements: false)
    }

    func combinationsWithRepeatingElements(length: Int) -> Combinations<Self> {
        return Combinations(sequence: self, length: length, repeatingElements: true)
    }
}

/// An iterator-sequence that returns the combinations of a specified length of elements in a sequence.
/// See the `combinations(length:repeatingElements:)` Sequence and LazySequenceProtocol method.
public struct Combinations<S: Sequence>: IteratorProtocol, Sequence {
    private let values: [S.Iterator.Element]
    private let combinationLength: Int
    private let repeatingElements: Bool
    private var indicesIterator: AnyIterator<[Int]>

    fileprivate init(sequence: S, length: Int, repeatingElements: Bool) {
        values = Array(sequence)
        combinationLength = length
        self.repeatingElements = repeatingElements
        if repeatingElements {
            indicesIterator = AnyIterator(product(values.indices, repeated: length))
        } else {
            indicesIterator = AnyIterator(Permutations(sequence: values.indices, length: length, repeatingElements: false))
        }
    }

    public mutating func next() -> [S.Iterator.Element]? {
        var indices: [Int]
        repeat {
            guard let nextIndices = indicesIterator.next() else {
                return nil
            }
            indices = nextIndices
        } while indices.sorted() == indices

        let combination = indices.map { values[$0] }
        return combination.isEmpty ? nil : combination
    }
}

/// An iterator-sequence that returns the combinations of a specified length of elements in a sequence.
/// See the `combinations(length:repeatingElements:)` Sequence and LazySequenceProtocol method.
public struct CombinationsBigInt<S: Sequence>: IteratorProtocol, Sequence {
    private let values: [S.Iterator.Element]
    private let valuesCount: Int
    private let combinationLength: Int
    private var iterator: _BigInt<UInt32>

    fileprivate init(sequence: S, length: Int) {
        values = Array(sequence)
        valuesCount = values.count
        combinationLength = length
        iterator = _BigInt(1) << valuesCount
    }

    public mutating func next() -> [S.Iterator.Element]? {
        guard iterator > 0 else {
            return nil
        }
        repeat {
            iterator -= 1
            guard iterator >= 0 else {
                return nil
            }
        } while iterator.nonzeroBitCount != combinationLength

        let combination = iterator.indiciesForSetBits()
            .map { values[valuesCount - $0 - 1] }
        return combination
    }
}
