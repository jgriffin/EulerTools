//
// Created by John Griffin on 11/17/23
//

import Foundation

public extension String.StringInterpolation {
    // MARK: - float decimal places

    mutating func appendInterpolation(dotOne value: Float) {
        appendLiteral(String(format: "%.1f", value))
    }

    mutating func appendInterpolation(dotTwo value: Float) {
        appendLiteral(String(format: "%.2f", value))
    }

    mutating func appendInterpolation(dotTwo value: Double) {
        appendLiteral(String(format: "%.2f", value))
    }

    mutating func appendInterpolation(letter: some Letter) {
        if letter == .newline {
            appendLiteral("\u{2424}")
        } else {
            appendLiteral("\(letter.asCharacter)")
        }
    }

    mutating func appendInterpolation(letters: some Sequence<some Letter>) {
        for letter in letters {
            appendLiteral("\(letter: letter)")
        }
    }
}

public extension String.StringInterpolation {
    // MARK: - ElementCounts<some Letter>

    mutating func appendInterpolation(
        letterCounts counts: ElementCounts<some Letter>,
        prefix: Int = .max
    ) {
        appendLiteral("\(counts.uniqueCount) letters\n")
        appendLiteral("totalCount - \(counts.countOf.values.reduce(0,+))\n")

        let elements = counts.elementsSortedByCount().prefix(prefix)
        for element in elements {
            appendLiteral("\(letter: element)\t\(counts.countOf[element, default: 0])\n")
        }
    }

    mutating func appendInterpolation(
        letterAsPercentages counts: ElementCounts<some Letter>,
        prefix: Int = .max
    ) {
        appendLiteral("\(counts.uniqueCount) letters\n")

        let elements = counts.elementsSortedByCount().prefix(prefix)
        for element in elements {
            appendLiteral("\(letter: element)\t\(dotTwo: counts.probabilityOf(element) * 100)\n")
        }
    }
}

public extension String.StringInterpolation {
    // MARK: - ElementCounts<some Sequence<some Letter>>

    mutating func appendInterpolation(
        lettersCounts counts: ElementCounts<some Sequence<some Letter>>,
        prefix: Int = .max
    ) {
        appendLiteral("\(counts.uniqueCount) letters\n")
        appendLiteral("totalCount - \(counts.countOf.values.reduce(0,+))\n")

        let elements = counts.elementsSortedByCount().prefix(prefix)
        for element in elements {
            appendLiteral("\(letters: element)\t\(counts.countOf[element, default: 0])\n")
        }
    }

    mutating func appendInterpolation(
        lettersAsPercentages counts: ElementCounts<some Sequence<some Letter>>,
        prefix: Int = .max
    ) {
        appendLiteral("\(counts.uniqueCount) letters\n")

        let elements = counts.elementsSortedByCount().prefix(prefix)
        for element in elements {
            appendLiteral("\(letters: element)\t\(dotTwo: counts.probabilityOf(element) * 100)\n")
        }
    }
}

public extension String.StringInterpolation {
    // MARK: - ElementCounts<some Any>

    mutating func appendInterpolation(
        counts: ElementCounts<some Any>,
        prefix: Int = .max
    ) {
        appendLiteral("\(counts.uniqueCount) letters\n")
        appendLiteral("totalCount - \(counts.countOf.values.reduce(0,+))\n")

        let elements = counts.elementsSortedByCount().prefix(prefix)
        for element in elements {
            appendLiteral("\(element)\t\(counts.countOf[element, default: 0])\n")
        }
    }

    mutating func appendInterpolation(
        asPercentages counts: ElementCounts<some Any>,
        prefix: Int = .max
    ) {
        appendLiteral("\(counts.uniqueCount) letters\n")

        let elements = counts.elementsSortedByCount().prefix(prefix)
        for element in elements {
            appendLiteral("\(element)\t\(dotTwo: counts.probabilityOf(element) * 100)\n")
        }
    }
}
