import EulerTools
import XCTest

final class WordListTests: XCTestCase {
    func testAllWordlistsExist() throws {
        for wordlist in Wordlist.allCases {
            do {
                _ = try wordlist.data
            } catch {
                XCTFail(wordlist.rawValue)
            }
        }
    }

    func testIsValidAsciiAllWordlists() throws {
        for wordlist in Wordlist.allCases {
            let start = Date()
            XCTAssertTrue((try? isValidatedAscii(wordlist)) ?? false, "\(wordlist.rawValue)")
            let end = Date()
            print(wordlist.rawValue, "duration: ", "\(dotTwo: end.timeIntervalSince(start))")
        }
    }

    func testWordCount_english_words_alpha() throws {
        let words = try Wordlist.english_words_alpha.asString.split(separator: .newline)
        XCTAssertEqual(words.count, 370_105)
    }

    func testLetterCounts() throws {
        let words = try Wordlist.english_words_alpha.data.asAscii
        let counts = ElementCounts(words)

        print(counts)
    }
}

extension WordListTests {
    func isValidatedAscii(_ wordlist: Wordlist) throws -> Bool {
        var isValidAscii = true
        let bytes = try wordlist.data.asArray
        try bytes.enumerated().forEach { i, ch in
            if !ch.isValidAscii {
                try print(wordlist.rawValue, i, ch, bytes.dropFirst(max(0, i - 10)).prefix(10).asString)
                isValidAscii = false
            }
        }
        return isValidAscii
    }
}
