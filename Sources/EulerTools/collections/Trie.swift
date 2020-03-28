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
public struct Trie {
    private(set) var isLeaf: Bool = false
    
    private var suffixTriesByCh = [Character: Trie]()
    private static let emptyCharacters = Array("")
    
    // MARK: init
    
    public init() {}
    
    public init(substring: Substring) {
        addSubstring(substring)
    }
    
    public static func fromStrings(_ strings: [String]) -> Trie {
        var trie = Trie()
        strings.forEach { string in
            trie.addSubstring(string[...])
        }
        return trie
    }
    
    // MARK: contains
    
    public func contains(_ substring: Substring) -> Bool {
        guard let firstChar = substring.first else {
            return isLeaf
        }
        
        guard let suffixTrie = suffixTriesByCh[firstChar] else {
            return false
        }
        
        return suffixTrie.contains(substring.dropFirst())
    }
    
    public func nextChars() -> [Character] {
        Array(suffixTriesByCh.keys)
    }
    
    public func suffixes() -> [[Character]] {
        let suffs = suffixTriesByCh
            .reduce(into: [[Character]]()) { result, chAndTrie in
                result.append(contentsOf: chAndTrie.value.suffixes().map { suffix in
                    [chAndTrie.key] + suffix
                })
            }
        
        if isLeaf {
            return [Self.emptyCharacters] + suffs
        } else {
            return suffs
        }
    }
    
    public func suffixTrie(withPrefix prefix: Substring) -> Trie? {
        guard let firstCh = prefix.first else {
            return isLeaf ? self : nil
        }
        return suffixTriesByCh[firstCh]?.suffixTrie(withPrefix: prefix.dropFirst())
    }
    
    // MARK: updating trie
    
    public mutating func addSubstring(_ substring: Substring) {
        guard let firstChar = substring.first else {
            isLeaf = true
            return
        }
        
        if suffixTriesByCh[firstChar] == nil {
            suffixTriesByCh[firstChar] = Trie()
        }
        
        suffixTriesByCh[firstChar]?.addSubstring(substring.dropFirst())
    }
}
