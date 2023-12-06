
import EulerTools
import XCTest

final class LetterMapTests: XCTestCase {
    func testMappingString() {
        let tests: [(source: String, mapFrom: String, mapTo: String, check: String)] = [
            ("abc", "ac", "bb", "bbb"),
            ("a", "b", "c", "a"),
        ]

        tests.forEach { test in
            let mapper = LetterMap.mapOrPass(zip(test.mapFrom, test.mapTo))
            let result = test.source.compactMap(mapper)
            XCTAssertEqual(result, test.check.asArray)
        }
    }

    func testRemovingSpaces() {
        let source = "a b c d"

        let result = source.compactMap(.exclude(.space))
        XCTAssertEqual(result, "abcd".asCharacters)
    }

    func testUppercasingAndRemovingSpaces() {
        let source = "a b c d"

        let mapping = LetterMap<Character>.exclude(.space).then(.uppercasedOrDrop)
        let result = source.compactMap(mapping)
        XCTAssertEqual(result, "ABCD".asCharacters)
    }

    func testKeeping() {
        let source = "ab1 !"

        let result = source.compactMap(.include(.isAlphaDigit))
        XCTAssertEqual(result, "ab1".asCharacters)
    }
}
