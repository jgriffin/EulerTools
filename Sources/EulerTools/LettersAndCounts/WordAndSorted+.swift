//
//  StringProtocol+sortLetters.swift
//
//
//  Created by Griff on 11/25/20.
//

import Foundation

public extension WordAndSorted {
    struct Diff: Equatable {
        public let leftOnly: [Character]
        public let rightOnly: [Character]

        public init(
            leftOnly: [Character],
            rightOnly: [Character]
        ) {
            self.leftOnly = leftOnly
            self.rightOnly = rightOnly
        }
    }

    // isSortedSubset(of:) - all characters exist in other
    // assumes sorted strings as input
    func isSubset(of other: WordAndSorted<some StringProtocol>) -> Bool {
        var selfIt = sorted.makeIterator()
        var otherIt = other.sorted.makeIterator()

        var s = selfIt.next()
        var o = otherIt.next()

        while s != nil, o != nil {
            guard s! >= o! else { return false }

            if s! == o! {
                s = selfIt.next()
                o = otherIt.next()
            } else {
                o = otherIt.next()
            }
        }

        return s == nil
    }

    func diffSorted(_ other: WordAndSorted<some StringProtocol>) -> Diff {
        diffSorted(other.sorted)
    }

    func diffSorted(_ otherCharacters: [Character]) -> Diff {
        var leftOnly = [Character]()
        var rightOnly = [Character]()

        var selfIt = sorted.makeIterator()
        var otherIt = otherCharacters.makeIterator()
        var s = selfIt.next()
        var o = otherIt.next()

        while s != nil, o != nil {
            if s! < o! {
                leftOnly.append(s!)
                s = selfIt.next()
            } else if s! > o! {
                rightOnly.append(o!)
                o = otherIt.next()
            } else {
                s = selfIt.next()
                o = otherIt.next()
            }
        }

        if let s {
            leftOnly.append(s)
        }

        if let o {
            rightOnly.append(o)
        }

        return Diff(leftOnly: leftOnly, rightOnly: rightOnly)
    }
}
