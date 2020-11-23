//
//  Product.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/31/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

// Implementation of pythons.itertools product
// from https://github.com/mpangburn/IteratorTools/blob/master/Sources/Product.swift

/**
 Returns an iterator-sequence for the Cartesian product of the sequences.
 ```
 let values = product([1, 2, 3], [4, 5, 6, 7], [8, 9])
 // [1, 4, 8], [1, 4, 9], [1, 5, 8], [1, 5, 9], [1, 6, 8], ... [3, 7, 9]
 ```
 - Parameter sequences: The sequences from which to compute the product.
 - Returns: An iterator-sequence for the Cartesian product of the sequences.
 */
public func product<S: Sequence>(_ sequences: S...) -> CartesianProduct<S> {
    CartesianProduct(sequences)
}

/**
 Returns an iterator-sequence for the Cartesian product of the sequence repeated with itself a number of times.
 ```
 let values = product([1, 2, 3], repeated: 2)
 // Equivalent to product([1, 2, 3], [1, 2, 3])
 ```
 - Parameters:
 - sequence: The sequence from which to compute the product.
 - repeated: The number of times to repeat the sequence with itself in computing the product.
 - Returns: An iterator-sequence for the Cartesian product of the sequence repeated with itself a number of times.
 */
public func product<S: Sequence>(_ sequence: S, repeated: Int) -> CartesianProduct<S> {
    let sequences = Array(repeating: sequence, count: repeated)
    return CartesianProduct(sequences)
}

/**
 Returns an iterator-sequence for the Cartesian product of two sequences containing elements of different types.
 ```
 let values = mixedProduct(["a", "b"], [1, 2, 3])
 // ("a", 1), ("a", 2), ("a", 3), ("b", 1), ("b", 2), ("b", 3)
 ```
 - Parameters:
 - firstSequence: The first of the two sequences used in computing the product.
 - secondSequence: The second of the two sequences used in computing the product.
 - Returns: An iterator-sequence for the Cartesian product of two sequences containing elements of different types.
 */
public func mixedProduct<S1: Sequence, S2: Sequence>(_ firstSequence: S1, _ secondSequence: S2) -> MixedTypeCartesianProduct<S1, S2> {
    // If this function is named `product`, "ambiguous reference to `product`" error can occur
    MixedTypeCartesianProduct(firstSequence, secondSequence)
}

/// An iterator-sequence for the Cartesian product of multiple sequences of the same type.
/// See `product(_:)`.
public struct CartesianProduct<S: Sequence>: IteratorProtocol, Sequence {
    private let sequences: [S]
    private var iterators: [S.Iterator]
    private var currentValues: [S.Iterator.Element] = []

    fileprivate init(_ sequences: [S]) {
        self.sequences = sequences
        iterators = sequences.map { $0.makeIterator() }
    }

    public mutating func next() -> [S.Iterator.Element]? {
        guard !currentValues.isEmpty else {
            var firstValues: [S.Iterator.Element] = []
            for index in iterators.indices {
                guard let value = iterators[index].next() else {
                    return nil
                }
                firstValues.append(value)
            }
            currentValues = firstValues
            return firstValues
        }

        for index in currentValues.indices.reversed() {
            if let value = iterators[index].next() {
                currentValues[index] = value
                return currentValues
            }

            guard index != 0 else {
                return nil
            }

            iterators[index] = sequences[index].makeIterator()
            currentValues[index] = iterators[index].next()!
        }

        return currentValues
    }
}

/// An iterator-sequence for the Cartesian product of two sequences of different types.
/// See `mixedProduct(_:_:)`.
public struct MixedTypeCartesianProduct<S1: Sequence, S2: Sequence>: IteratorProtocol, Sequence {
    private let secondSequence: S2
    private var firstIterator: S1.Iterator
    private var secondIterator: S2.Iterator
    private var currentFirstElement: S1.Iterator.Element?

    fileprivate init(_ firstSequence: S1, _ secondSequence: S2) {
        self.secondSequence = secondSequence
        firstIterator = firstSequence.makeIterator()
        secondIterator = secondSequence.makeIterator()
        currentFirstElement = firstIterator.next()
    }

    public mutating func next() -> (S1.Iterator.Element, S2.Iterator.Element)? {
        // Avoid stack overflow
        guard secondSequence.underestimatedCount > 0 else {
            return nil
        }

        guard let firstElement = currentFirstElement else {
            return nil
        }

        guard let secondElement = secondIterator.next() else {
            currentFirstElement = firstIterator.next()
            secondIterator = secondSequence.makeIterator()
            return next()
        }

        return (firstElement, secondElement)
    }
}
