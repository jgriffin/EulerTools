//
// Created by John Griffin on 11/21/23
//

public struct Englishness: Comparable, CustomStringConvertible {
    public let textual: Float
    public let chi2: Float

    public init(textual: Float, chi2: Float) {
        self.textual = textual
        self.chi2 = chi2
    }

    public init?(minTextual: Float = 0.9, _ sample: some Collection<Ascii>) {
        guard let englishness = TextEvaluator.englishness(minTextual: minTextual, sample)
        else {
            return nil
        }
        self = englishness
    }

    public static func < (lhs: Self, rhs: Self) -> Bool { lhs.chi2 < rhs.chi2 }

    public var description: String { "\(dotOne: textual)  \(dotTwo: chi2)" }
}

public enum TextEvaluator {
    static let englishLowercaseCounts = try! ElementCounts(
        Wordlist.mit_wordlist_10000.data.asAscii(.newlinesToSpace)
    )

    public static func englishness(
        minTextual: Float = 0.9,
        _ sample: some Collection<Ascii>
    ) -> Englishness? {
        let sampleCounts = ElementCounts(sample).map(.lowercasedOrPass.then(.newlineToSpace))

        let texualScore = Float(sampleCounts.countOf.filter(\.key.isTextual).map(\.value).reduce(0,+)) / Float(sampleCounts.totalCount)
        guard texualScore >= minTextual else {
            return nil
        }

        let chi2 = TextEvaluator.chiSquaredDistance(
            compare: sampleCounts,
            withModel: Self.englishLowercaseCounts
        )
        return .init(textual: texualScore, chi2: chi2)
    }

    // lower is better
    public static func chiSquaredDistance<Element: Hashable>(
        compare sample: ElementCounts<Element>,
        withModel model: ElementCounts<Element>
    ) -> Float {
        let elements = sample.elements.union(model.elements)
        let errors = elements
            .map { element in
                let observed = sample[element].map(Float.init) ?? 0
                let expected = model[element].map(Float.init) ?? 0.5
                return (observed - expected) * (observed - expected) / (expected * expected)
            }

        return errors.reduce(0,+)
    }
}
