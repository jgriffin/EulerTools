//
//  XORDecryptor.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/11/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

extension Sequence {
    func everyNth(_ n: UInt) -> AnySequence<Element> {
        return AnySequence { () -> AnyIterator<Self.Element> in
            var inner = self.makeIterator()

            return AnyIterator {
                let val = inner.next()
                if n > 1 {
                    (1 ..< n).forEach { _ in
                        _ = inner.next()
                    }
                }
                return val
            }
        }
    }
}

class XORDecryptor {
    static func data(from string: String) -> [UInt8] {
        return Array(string.utf8)
    }

    struct EncryptionKey: Sequence {
        let key: [UInt8]

        init(key: [UInt8]) { self.key = key }
        init(string: String) { self.init(key: XORDecryptor.data(from: string)) }

        typealias Element = UInt8
        func makeIterator() -> AnyIterator<UInt8> {
            let key = self.key
            var index: Int = 0

            return AnyIterator {
                let val = key[index % key.count]
                index += 1
                return val
            }
        }

        func encode<S: Sequence>(cipher: S) -> [UInt8] where S.Element == UInt8 {
            return zip(cipher, makeIterator())
                .map { $0 ^ $1 }
        }
    }

    static let space: UInt8 = XORDecryptor.data(from: " ").first!
    static let lowercase = XORDecryptor.data(from: "abcdefghijklmnopqrstuvwxyz")
    static let lettersSet = Set(XORDecryptor.data(from: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"))

    struct Statistics {
        typealias LetterStats = (spaces: Int, letters: Int, unknown: Int)

        static func isBetterThan(_ lhs: LetterStats, _ rhs: LetterStats) -> Bool {
            return lhs.spaces > rhs.spaces
        }

        static func isBetterThan(_ lhs: (UInt8, LetterStats), _ rhs: (UInt8, LetterStats)) -> Bool {
            return isBetterThan(lhs.1, rhs.1)
        }

        static func calculateStatistics<S: Sequence>(for seq: S) -> LetterStats where S.Element == UInt8 {
            var (spaces, letters, unknown) = (0, 0, 0)
            seq.forEach { ch in
                switch ch {
                case XORDecryptor.space: spaces += 1
                case _ where XORDecryptor.lettersSet.contains(ch): letters += 1
                default: unknown += 1
                }
            }
            return (spaces, letters, unknown)
        }

        static func calculateStatisticsByLetter<S: Sequence>(for seq: S) ->
            [UInt8: LetterStats] where S.Element == UInt8 {
            var stats = [UInt8: LetterStats]()

            stats[0] = calculateStatistics(for: seq)

            XORDecryptor.lettersSet.forEach { ch in
                let key = EncryptionKey(key: [ch])
                let cipher = key.encode(cipher: seq)
                stats[ch] = calculateStatistics(for: cipher)
            }

            return stats
        }
    }

    struct WordChecker {
        static func countWordsInWordList(string: String) -> (verified: Int, total: Int) {
            var verified = 0
            var total = 0

            string.split(separator: " ").forEach { maybeWord in
                total += 1
                if WordList.instance.setOfWords.contains(String(maybeWord)) {
                    verified += 1
                }
            }
            return (verified, total)
        }
    }
}
