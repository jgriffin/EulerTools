import EulerTools
import XCTest

final class WordleTests: XCTestCase {
    func testWorldleList() {
        let wordlelist = try! Wordlist.wordle.asString.split(separator: .newline)
        XCTAssertEqual(wordlelist.count, 12947)

        let wordAndSets = wordlelist.map { $0.wordAndSet() }

        let byCh = wordAndSets.reduce(into: [Character: [Substring]]()) { result, was in
            was.letters.forEach { ch in
                result[ch, default: []].append(was.word)
            }
        }
        let chCounts = byCh.mapValues { $0.count }

        let wordAndIntersectCounts = wordAndSets
            .map { was -> (word: Substring, count: Int) in
                (was.word, was.letters.reduce(0) { _, ch in chCounts[ch, default: 0] })
            }
            .sorted { lhs, rhs in lhs.1 > rhs.1 }

        XCTAssertEqual(wordAndIntersectCounts.count, 12947)
        print(wordAndIntersectCounts.prefix(20).map(\.word))

        XCTAssertEqual(wordAndIntersectCounts.count, 12947)
    }
}
