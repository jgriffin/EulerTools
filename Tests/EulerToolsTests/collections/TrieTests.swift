//
//  TrieTests.swift
//
//
//  Created by John Griffin on 3/28/20.
//

import EulerTools
import XCTest

class TrieTests: XCTestCase {
    func testEmptyTrie() {
        let emptyTrie = Trie<Character>()

        XCTAssertEqual(emptyTrie.contains(""), false)
        XCTAssertEqual(emptyTrie.allSuffixes(), [])
    }

    func testEmptyStringTrie() {
        let trie = Trie([""])

        XCTAssertEqual(trie.contains(""), true)
        XCTAssertEqual(trie.allSuffixes(), [Array("")])
    }

    func testValueTrie() {
        let trie = Trie(["apple", "banana"])

        XCTAssertEqual(trie.contains("app"), false)
        XCTAssertEqual(trie.contains("b"), false)
        XCTAssertEqual(trie.contains("apple"), true)
        XCTAssertEqual(trie.contains("banana"), true)

        XCTAssertEqual(Set(trie.allSuffixes()),
                       Set(chArrays(["apple", "banana"])))
    }

    func testCommonPrefixes() {
        let trie = Trie(["a", "apple", "aardvark", "anvil", "banana"])

        XCTAssertEqual(trie.contains("a"), true)
        XCTAssertEqual(trie.contains("aa"), false)
        XCTAssertEqual(trie.contains("apple"), true)
        XCTAssertEqual(trie.contains("aardvark"), true)
        XCTAssertEqual(trie.contains("anvil"), true)
        XCTAssertEqual(trie.contains("banana"), true)
    }

    func testSuffixTrieWithPrefix() {
        let trie = Trie(["a", "apple", "aardvark", "anvil", "banana"])

        XCTAssertNil(trie.suffixTrie(withPrefix: "and"))
        XCTAssertNil(trie.suffixTrie(withPrefix: "cat"))

        let aSuffixTrie = trie.suffixTrie(withPrefix: "a")
        XCTAssertEqual(Set(aSuffixTrie!.allSuffixes()),
                       Set(chArrays(["", "pple", "ardvark", "nvil"])))
    }

    // MARK: - contained prefixes

    func testContainedPrefixesNone() {
        let trie = Trie(["a", "ab", "abc"])
        let result = trie.containedPrefixes(of: "bcd")
        XCTAssertEqual(result, [])
    }

    func testContainedPrefixes() {
        let trie = Trie(["a", "ab", "abc"])
        let result = trie.containedPrefixes(of: "abcd")
        XCTAssertEqual(result, ["a", "ab", "abc"])
    }

    func testContainedPrefixesEmpty() {
        let trie = Trie(["", "a", "ab", "abc"])
        let result = trie.containedPrefixes(of: "abcd")
        XCTAssertEqual(result, ["", "a", "ab", "abc"])
    }

    func testContainedPrefixesSkip() {
        let trie = Trie(["", "a", "abc"])
        let result = trie.containedPrefixes(of: "abcd")
        XCTAssertEqual(result, ["", "a", "abc"])
    }

    // MARK: helpers

    private func chArrays(_ strings: [String]) -> [[Character]] {
        strings.map { Array($0) }
    }
}
