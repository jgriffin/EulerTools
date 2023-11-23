//
// Created by John Griffin on 11/21/23
//

public enum TextEvaluator {
    static let englishLowercaseCounts = try! ElementCounts(
        Wordlist.mit_wordlist_10000.data.asAscii(.newlinesToSpace)
    )

    public struct EnglishnessScore: Comparable, CustomStringConvertible {
        public let textual: Float
        public let chi2: Float

        public init(textual: Float, chi2: Float) {
            self.textual = textual
            self.chi2 = chi2
        }

        public static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.chi2 > rhs.chi2
        }

        public var description: String {
            "\(dotOne: textual)  \(dotTwo: chi2)"
        }
    }

    public static func englishnessScore(
        minTextualScore: Float = 0.9,
        _ sample: some Collection<Ascii>
    ) -> EnglishnessScore? {
        let sampleCounts = ElementCounts(sample).map(.lowercasedOrPass.then(.newlineToSpace))

        let texualScore = Float(sampleCounts.countOf.filter(\.key.isTextual).map(\.value).reduce(0,+)) / Float(sampleCounts.totalCount)
        guard texualScore >= minTextualScore else {
            return nil
        }

        let chi2 = TextEvaluator.chiSquaredDistance(
            compare: sampleCounts,
            withModel: Self.englishLowercaseCounts
        )
        return .init(textual: texualScore, chi2: chi2)
    }

    // higher is better
    public static func xtextualLettersScore(_ sample: some Collection<Ascii>) -> Float {
        Float(sample.filter(Set<Ascii>.isTextual.contains).count) / max(1, Float(sample.count))
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
