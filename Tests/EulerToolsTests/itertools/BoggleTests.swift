//
//  BoggleTests.swift
//
//
//  Created by John Griffin on 3/28/20.
//

import EulerTools
import XCTest

// Given a dictionary, a method to do lookup in dictionary and a M x N board where every cell has one character. Find all possible words that can be formed by a sequence of adjacent characters. Note that we can move to any of 8 adjacent characters, but a word should not have multiple instances of same cell.
//
// Example:
//
// Input: dictionary[] = {"GEEKS", "FOR", "QUIZ", "GO"};
//       boggle[][]   = {{'G','I','Z'},
//                       {'U','E','K'},
//                       {'Q','S','E'}};
//
// Output:  Following words of dictionary are present
//         GEEKS, QUIZ
//
// Input:
// The first line of input contains an integer T denoting the no of test cases . Then T test cases follow. Each test case contains an integer x denoting the no of words in the dictionary. Then in the next line are x space separated strings denoting the contents of the dictinory. In the next line are two integers N and M denoting the size of the boggle. The last line of each test case contains NxM space separated values of the boggle.
//
// Output:
// For each test case in a new line print the space separated sorted distinct words of the dictionary which could be formed from the boggle. If no word can be formed print -1.
//
// Constraints:
// 1<=T<=10
// 1<=x<=10
// 1<=n,m<=7
//
// Example:
// Input:
// 1
// 4
// GEEKS FOR QUIZ GO
// 3 3
// G I Z U E K Q S E

class BoggleTests: XCTestCase {
    func testBoggleExample() {
        let trie = Trie<Character>(["GEEKS", "FOR", "QUIZ", "GO"])
        let boggleBoard = BoggleBoard(boardSize: (3, 3),
                                      wordsTrie: trie)

        let words = boggleBoard.findWords(in: Array("GIZUEKQSE"))

        XCTAssertEqual(words, ["GEEKS", "QUIZ"])
    }
}
