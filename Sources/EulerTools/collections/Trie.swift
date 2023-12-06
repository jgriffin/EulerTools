//
//  Trie.swift
//
//
//  Created by John Griffin on 3/28/20.
//

import Foundation

/**
 Trie is a tree where the descendants for a node all share the same prefix and in therefore and
 an efficent structure when we're interested only it possiblitiles that share a prefix.

 Each level of the tree may or may itself be a leaf node, as indicated by the isLeaf property
 */
public struct Trie<Element: Hashable> {
    private(set) var isLeaf: Bool = false
    private var subTries = [Element: Trie]()

    // MARK: - init

    public init() {}

    public init(_ seqs: some Sequence<some Collection<Element>>) {
        seqs.forEach { addBranches($0) }
    }

    // MARK: - contains

    public func contains(_ seq: some Collection<Element>) -> Bool {
        guard let firstChar = seq.first else {
            return isLeaf
        }
        guard let suffixTrie = subTries[firstChar] else {
            return false
        }
        return suffixTrie.contains(seq.dropFirst())
    }

    public func containedPrefixes<C: Collection<Element>>(of seq: C) -> [C.SubSequence] {
        var results: [C.SubSequence] = []

        var curTrie: Trie = self
        var curEndIndex = seq.startIndex

        while curEndIndex <= seq.endIndex {
            if curTrie.isLeaf {
                results.append(seq[seq.startIndex ..< curEndIndex])
            }
            guard curEndIndex < seq.endIndex,
                  let nextTrie = curTrie.subTries[seq[curEndIndex]]
            else {
                break
            }

            curTrie = nextTrie
            curEndIndex = seq.index(after: curEndIndex)
        }

        return results
    }

    public func suffixTrie(withPrefix prefix: some Collection<Element>) -> Trie? {
        guard let firstCh = prefix.first else {
            return self
        }
        return subTries[firstCh]?.suffixTrie(withPrefix: prefix.dropFirst())
    }

    // MARK: - walk

    public func nextElements() -> [Element] {
        Array(subTries.keys)
    }

    public func allSuffixes() -> [[Element]] {
        let suffs = subTries.reduce(into: [[Element]]()) { result, elementSubtrie in
            result.append(contentsOf:
                elementSubtrie.value.allSuffixes()
                    .map { suffix in [elementSubtrie.key] + suffix }
            )
        }

        if isLeaf {
            return [[]] + suffs
        } else {
            return suffs
        }
    }

    // MARK: - updating trie

    public mutating func addBranches(_ seq: some Collection<Element>) {
        guard let firstChar = seq.first else {
            isLeaf = true
            return
        }

        if subTries[firstChar] == nil {
            subTries[firstChar] = Trie()
        }
        subTries[firstChar]!.addBranches(seq.dropFirst())
    }
}
