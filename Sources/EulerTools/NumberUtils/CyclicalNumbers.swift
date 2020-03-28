//
//  CyclicalNumbers.swift
//
//
//  Created by John Griffin on 10/27/19.
//

import Foundation

public class CyclicalNumbers {
    private let endOf: (Int) -> Int
    private let startOf: (Int) -> Int

    private var ranges: [[Int]]!
    private var cyclicLength: Int!
    private var current: [Int]!
    private var iterators: [AnyIterator<Int>]!

    public init(endOf: @escaping (Int) -> Int,
                startOf: @escaping (Int) -> Int) {
        self.endOf = endOf
        self.startOf = startOf
    }

    public func isCyclic(_ numbers: [Int]) -> Bool {
        // last cycles with first 2
        let last2s = numbers.map(CyclicalNumbers.last2Of4)
        let first2s = numbers.map(CyclicalNumbers.first2Of4)

        return zip(last2s.dropLast(), first2s.dropFirst()).allSatisfy { $0 == $1 } &&
            last2s.last! == first2s.first!
    }

    public func findCyclics(_ ranges: [[Int]]) -> [[Int]] {
        self.ranges = ranges
        cyclicLength = ranges.count
        current = Array()
        iterators = Array()
        current.reserveCapacity(cyclicLength)
        iterators.reserveCapacity(cyclicLength)

        // start with first
        _ = pushIteratorAndCurrent()

        var result = [[Int]]()

        while !current.isEmpty {
            if current.count == cyclicLength,
                endOf(current.last!) == startOf(current.first!) {
                result.append(current)
            }

            let didAdvance = current.count < cyclicLength ?
                pushIteratorAndCurrent() :
                advanceLastIterator()
            if !didAdvance {
                backtrackIterators()
            }
        }
        return result
    }

    // internal

    private func pushIteratorAndCurrent() -> Bool {
        // add an iterator
        let it = makeIteratorAtPosition(current.count)

        guard let next = it.next() else {
            return false
        }

        iterators.append(it)
        current.append(next)
        return true
    }

    private func advanceLastIterator() -> Bool {
        let lastIndex = current.count - 1
        guard let next = iterators[lastIndex].next() else {
            return false
        }

        current[lastIndex] = next
        return true
    }

    private func backtrackIterators() {
        while !current.isEmpty, !advanceLastIterator() {
            iterators.removeLast()
            current.removeLast()
        }
    }

    private func makeIteratorAtPosition(_ pos: Int) -> AnyIterator<Int> {
        assert(pos < cyclicLength)
        guard pos > 0 else {
            return AnyIterator(ranges[0].makeIterator())
        }

        let startsWith = endOf(current[pos - 1])
        return AnyIterator(ranges[pos].filter { startOf($0) == startsWith }.makeIterator())
    }
}

extension CyclicalNumbers {
    public static func first2Of4(_ n: Int) -> Int { n / 100 }
    public static func last2Of4(_ n: Int) -> Int { n % 100 }
}
