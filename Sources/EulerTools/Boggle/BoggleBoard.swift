//
//  Boggle.swift
//
//
//  Created by John Griffin on 3/28/20.
//

import Foundation

public class BoggleBoard: BoardWalk {
    let wordsTrie: Trie

    public init(boardSize: BoardWalk.BoardSize,
                wordsTrie: Trie)
    {
        self.wordsTrie = wordsTrie

        super.init(boardSize: boardSize,
                   allowedSteps: BoardWalk.squareAndDiagonalSteps)
    }

    public func findWords(in letters: [Character]) -> [String] {
        assert(letters.count == boardSize.rows * boardSize.cols)

        var words = [String]()

        let startingSquares = allSquares()

        func isDeadEndPath(_ path: Path) -> Bool {
            isDeadEndPathForLetters(path, letters: letters)
        }

        for startingSquare in startingSquares {
            let walker = Walker(from: startingSquare,
                                onBoard: self,
                                isDeadEndPath: isDeadEndPath)

            for path in walker {
                let bogglePath = boggleWordFromPath(path, letters)
                print(bogglePath)
                if wordsTrie.contains(bogglePath[...]) {
                    words.append(String(bogglePath))
                }
            }
        }

        return words.sorted()
    }

    func isDeadEndPathForLetters(_ path: Path, letters: [Character]) -> Bool {
        let boggleWord = boggleWordFromPath(path, letters)

        return wordsTrie
            .suffixTrie(withPrefix: boggleWord[...]) == nil
    }

    func boggleWordFromPath(_ path: BoardWalk.Path, _ letters: [Character]) -> String {
        let wordLetters = path
            .map(linearIndexForSquare)
            .map { letters[$0] }

        return String(wordLetters)
    }
}
