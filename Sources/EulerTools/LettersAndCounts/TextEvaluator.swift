//
// Created by John Griffin on 11/21/23
//

public enum TextEvaluator {
    // higher is better
    public static func textualLettersScore(_ sample: some Collection<Ascii>) -> Float {
        Float(sample.filter(Set<Ascii>.isTextual.contains).count) / max(1, Float(sample.count))
    }

    // lower is better
    public static func mseExpectedScore<Element: Hashable>(
        compare sample: ElementCounts<Element>,
        withModel model: ElementCounts<Element>
    ) -> Float {
        let elements = sample.elements.union(model.elements)
        let errors = elements.map { sample.laplaceOf($0) - model.laplaceOf($0) }
        let mse = errors.meanSquaredError * 1000
        return mse
    }
}

public extension TextEvaluator {
    struct LetterXoredScore: CustomStringConvertible {
        public let letter: Ascii
        public let xored: [Ascii]
        public let score: Float

        public var description: String {
            "\(letter: letter)\t\(dotOne: score)\t\(letters: xored)"
        }
    }

    static func letterXoreds(
        from letters: [Ascii],
        withMinTextualScore: Float = 0.9,
        in sample: some Collection<Ascii>
    ) -> [LetterXoredScore] {
        letters.lazy
            .map { letter in
                let xored = sample.map { $0 ^ letter }
                let score = textualLettersScore(xored)
                return LetterXoredScore(letter: letter, xored: xored, score: score)
            }
            .filter { $0.score >= withMinTextualScore }
    }
}
