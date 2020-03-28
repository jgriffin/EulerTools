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
        let emptyTrie = Trie()
        
        XCTAssertEqual(emptyTrie.contains(""), false)
        XCTAssertEqual(emptyTrie.suffixes(), [])
    }
    
    func testEmptyStringTrie() {
        let trie = Trie.fromStrings([""])
        
        XCTAssertEqual(trie.contains(""), true)
        XCTAssertEqual(trie.suffixes(), [Array("")])
    }
    
    func testValueTrie() {
        let trie = Trie.fromStrings(["apple", "banana"])
        
        XCTAssertEqual(trie.contains("app"), false)
        XCTAssertEqual(trie.contains("b"), false)
        XCTAssertEqual(trie.contains("apple"), true)
        XCTAssertEqual(trie.contains("banana"), true)
        
        XCTAssertEqual(Set(trie.suffixes()),
                       Set(chArrays(["apple", "banana"])))
    }
    
    func testCommonPrefixes() {
        let trie = Trie.fromStrings(["a", "apple", "aardvark", "anvil", "banana"])
        
        XCTAssertEqual(trie.contains("a"), true)
        XCTAssertEqual(trie.contains("aa"), false)
        XCTAssertEqual(trie.contains("apple"), true)
        XCTAssertEqual(trie.contains("aardvark"), true)
        XCTAssertEqual(trie.contains("anvil"), true)
        XCTAssertEqual(trie.contains("banana"), true)
    }
    
    func testSuffixTrieWithPrefix() {
        let trie = Trie.fromStrings(["a", "apple", "aardvark", "anvil", "banana"])
        
        XCTAssertNil(trie.suffixTrie(withPrefix: "and"))
        XCTAssertNil(trie.suffixTrie(withPrefix: "cat"))
        
        let aSuffixTrie = trie.suffixTrie(withPrefix: "a")
        XCTAssertEqual(Set(aSuffixTrie!.suffixes()),
                       Set(chArrays(["", "pple", "ardvark", "nvil"])))
    }
    
    // MARK: helpers
    
    private func chArrays(_ strings: [String]) -> [[Character]] {
        strings.map { Array($0) }
    }
}
