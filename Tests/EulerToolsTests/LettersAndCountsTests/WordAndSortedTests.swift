
import EulerTools
import XCTest

final class WordListSortedTests: XCTestCase {
    func testSortLettersLowercase() {
        let tests: [(string: String, check: String)] = [
            ("", ""),
            ("abcd", "abcd"),
            ("dcba", "abcd"),
        ]

        tests.forEach { test in
            XCTAssertEqual(test.string.wordAndSorted().sorted,
                           Array(test.check))
        }
    }

    func testSortLettersCapitalsFirst() {
        let tests: [(string: String, check: String)] = [
            ("aA", "Aa"),
            ("aBcD", "BDac"),
        ]

        tests.forEach { test in
            XCTAssertEqual(test.string.wordAndSorted().sorted,
                           Array(test.check))
        }
    }

    func testSortedDiff() {
        let tests: [(test: String, other: String, check: (leftOnly: String, rightOnly: String))] = [
            ("", "", ("", "")),
            ("", "a", ("", "a")),
            ("a", "a", ("", "")),
            ("a", "ab", ("", "b")),
            ("a", "aa", ("", "a")),
            ("b", "a", ("b", "a")),
            ("ab", "a", ("b", "")),
            ("ab", "aab", ("", "a")),
            ("aab", "ab", ("a", "")),
        ]

        tests.forEach { test in
            let testWas = test.test.wordAndSorted()

            let result = testWas.diffSorted(Array(test.other))
            let check = WordAndSorted<String>.Diff(
                leftOnly: Array(test.check.leftOnly),
                rightOnly: Array(test.check.rightOnly)
            )
            XCTAssertEqual(result, check, "\(test.test),\(test.other)")

            let otherWas = test.other.wordAndSorted()
            let reverseResult = otherWas.diffSorted(Array(test.test))
            let reverseCheck = WordAndSorted<String>.Diff(
                leftOnly: Array(test.check.rightOnly),
                rightOnly: Array(test.check.leftOnly)
            )

            XCTAssertEqual(reverseResult, reverseCheck, "\(test.other),\(test.test)")
        }
    }
}
