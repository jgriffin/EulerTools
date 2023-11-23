//
// Created by John Griffin on 11/21/23
//

public extension Sequence where Element: FloatingPoint {
    var mean: Element {
        let countSum: (count: Element, sum: Element) = lazy.reduce((0, 0)) { result, element in
            (result.count + 1, result.sum + element)
        }
        return countSum.sum / countSum.count
    }

    var meanSquared: Element {
        lazy.map { $0 * $0 }.mean
    }
}

public extension Sequence where Element: BinaryInteger {
    var mean: Float {
        let countSum: (count: Element, sum: Element) = lazy.reduce((0, 0)) { result, element in
            (result.count + 1, result.sum + element)
        }
        return Float(countSum.sum) / Float(countSum.count)
    }

    var meanSquared: Float {
        lazy.map { $0 * $0 }.mean
    }
}
