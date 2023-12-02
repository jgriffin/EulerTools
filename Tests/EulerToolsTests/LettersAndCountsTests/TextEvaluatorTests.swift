//
// Created by John Griffin on 11/20/23
//

import EulerTools
import XCTest

final class LikelihoodTests: XCTestCase {
    let wordlist = try! Wordlist.mit_wordlist_10000.data.asAscii(.newlinesToSpace)

    func testBayesian() throws {
        let counts = ElementCounts(wordlist)
        let bigramCounts = ElementCounts(wordlist.windows(ofCount: 2))

        let bayesian = Bayesian(
            probBGivenA: bigramCounts.laplaceOf,
            probB: { b in counts.laplaceOf(b.first!) }
        )

        let sample = try "The quick brown fox".asAscii

        let reductions = bayesian.probAReductions(0.4, givenBs: sample.windows(ofCount: 2))
        print(reductions.prefix(100).map { "\($0)" }.joined(separator: ", "))
    }

    func testCountsMeanSquaredError() throws {
        let counts = ElementCounts(wordlist)
        let sample = try "the quick brown fox jumps over the lazy dog".asAscii
        let sampleCounts = ElementCounts(sample)

        let elements = sampleCounts.elements
        let errors = zip(elements.map(counts.probabilityOf), elements.map(sampleCounts.probabilityOf))
            .map { $0.0 - $0.1 }
        print("count meanSquaredError", errors.meanSquared)
    }

    func testBigramCountsMeanSquaredError() throws {
        let counts = ElementCounts(wordlist.windows(ofCount: 2))
        let sample = try "the quick brown fox jumps over the lazy dog".asAscii
        let sampleCounts = ElementCounts(sample.windows(ofCount: 2))

        let elements = sampleCounts.elements
        let errors = zip(elements.map(counts.probabilityOf), elements.map(sampleCounts.probabilityOf))
            .map { $0.0 - $0.1 }
        print("bigram meanSquaredError", errors.meanSquared)
    }
}
