//
// Created by John Griffin on 11/16/23
//

import EulerTools
import XCTest

final class LetterCountTests: XCTestCase {
    let text = try! Wordlist.mit_wordlist_10000.asString

    func testCountsAndPercentages() throws {
        let counts = ElementCounts(text)

        XCTAssertEqual(counts.countOf["e"], 7601)
        XCTAssertEqual(counts.probabilityOf("e") * 100, 10.017132)

        print("\(counts: counts, prefix: 5)")

        print("\(heading: "percentages")")
        print("\(asPercentages: counts, prefix: 5)")
    }

    func testMap() throws {
        let text = try Wordlist.mit_wordlist_10000.asString
        let freq = ElementCounts(text)

        print("\(heading: "uppercasedOrPass")")
        print("\(asPercentages: freq.map(.uppercasedOrPass), prefix: 5)")

        print("\(heading: "lowercasedOrPass")")
        print("\(asPercentages: freq.map(.lowercasedOrPass), prefix: 5)")

        print("\(heading: "lowercasedOrDrop")")
        print("\(asPercentages: freq.map(.lowercasedOrDrop), prefix: 5)")
    }

    func testAcadNonAlphanum() throws {
        let freq = ElementCounts(text)

        print("\(heading: "letters")")
        print("\(counts: freq.map(.uppercasedOrDrop), prefix: 5)")

        print("\(heading: "non-alphanumeric to ~")")
        print("\(counts: freq.map(.replaceNotIn(.isAlphaNumeric, with: "~")), prefix: 5)")

        print("\(heading: "uppercased alphanumeric")")
        print("\(asPercentages: freq.map(.uppercasedOrPass.then(.include(.isAlphaNumeric))), prefix: 10)")

        print("\(heading: "non-alphanumeric to ~ percenatage")")
        print("\(asPercentages: freq.map(.replaceNotIn(.isAlphaNumeric, with: "~")), prefix: 4)")
    }

    func testMapNonAlphaNum() throws {
        let text = try Wordlist.mit_wordlist_10000.asString
        let freq = ElementCounts(text)

        print("letters")
        print("\(counts: freq.map(.uppercasedOrPass), prefix: 5)")

        print()
        print("non-alphanumeric to ~")
        print("\(counts: freq.map(.uppercasedOrPass.then(.replaceNotIn(.isAlphaNumeric, with: "~"))), prefix: 5)")
    }
}
