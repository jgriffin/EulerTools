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
