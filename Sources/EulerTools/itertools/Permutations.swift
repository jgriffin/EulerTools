//
//  Permutations.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/31/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

// Implemenations of python.itertools product
// borrowed from https://github.com/mpangburn/IteratorTools/blob/master/Sources/Permutations.swift

public extension Sequence {
    /**
     Returns an array containing the permutations of elements in the sequence, optionally of a specified length.
     ```
     let values = [1, 2, 3].permutations(repeatingElements: false)
     // [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
     let values = [1, 2, 3].permutations(length: 2, repeatingElements: true)
     // [[1, 1], [1, 2], [1, 3], [2, 1], [2, 2], [2, 3], [3, 1], [3, 2], [3, 3]]
     ```
     - Parameters:
     - length: The length of the permutations to return. Defaults to the length of the sequence.
     - repeatingElements: A boolean value determining whether or not elements can repeat in a permutation.
     - Returns: An array containing the permutations of elements in the sequence.
     */
    func permutations(length: Int? = nil, repeatingElements: Bool = false) -> [[Iterator.Element]] {
        Array(Permutations(sequence: self, length: length, repeatingElements: repeatingElements))
    }
}

public extension LazySequenceProtocol {
    /**
     Returns an iterator-sequence that returns the permutations of elements in the sequence, optionally of a specified length.
     ```
     let values = [1, 2, 3].lazy.permutations(repeatingElements: false)
     // [1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]
     let values = [1, 2, 3].lazy.permutations(length: 2, repeatingElements: true)
     // [1, 1], [1, 2], [1, 3], [2, 1], [2, 2], [2, 3], [3, 1], [3, 2], [3, 3]
     ```
     - Parameters:
     - length: The length of the permutations to return. Defaults to the length of the sequence.
     - repeatingElements: A boolean value determining whether or not elements can repeat in a permutation.
     - Returns: An an iterator-sequence that returns the permutations of elements in the sequence.
     */
    func permutations(length: Int? = nil, repeatingElements: Bool) -> Permutations<Self> {
        Permutations(sequence: self, length: length, repeatingElements: repeatingElements)
    }
}

/// An iterator-sequence that returns the permutations of elements in a sequence.
/// See the `permutations(repeatingElements:)` and `permutations(length:repeatingElements:)` Sequence and LazySequenceProtocol methods.
public struct Permutations<S: Sequence>: IteratorProtocol, Sequence {
    private let values: [S.Iterator.Element]
    private let permutationLength: Int
    private let repeatingElements: Bool
    private var indicesIterator: CartesianProduct<CountableRange<Int>>

    public init(sequence: S, length: Int?, repeatingElements: Bool) {
        values = Array(sequence)

        if let length = length {
            permutationLength = length
        } else {
            permutationLength = values.count
        }

        self.repeatingElements = repeatingElements
        indicesIterator = product(values.indices, repeated: permutationLength)
    }

    public mutating func next() -> [S.Iterator.Element]? {
        // while prevents recursion with repeated elements
        while true {
            guard let indices = indicesIterator.next() else {
                return nil
            }

            if !repeatingElements {
                guard Set(indices).count == permutationLength else {
                    continue
                }
            }

            let permutation = indices.map { values[$0] }
            return permutation.isEmpty ? nil : permutation
        }
    }
}
