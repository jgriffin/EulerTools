//
//  WordList.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/10/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

class WordList {
    static let instance = WordList()

    lazy var words = {
        self.readRawWordList()
            .components(separatedBy: CharacterSet.newlines)
    }()

    lazy var setOfWords = Set(words)

    // helpers

    func readRawWordList() -> String {
        guard let filepath = Bundle.main.path(forResource: "wordlist", ofType: "txt") else {
            fatalError("couldn't read wordlist.txt")
        }
        do {
            let words = try String(contentsOfFile: filepath)
            return words
        } catch {
            fatalError("couldn't parse wordlist.txt")
        }
    }
}
