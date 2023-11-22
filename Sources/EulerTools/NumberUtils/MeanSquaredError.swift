//
// Created by John Griffin on 11/21/23
//

public extension Collection where Element: FloatingPoint {
    var meanSquaredError: Element {
        lazy.map { $0 * $0 }.reduce(0, +) / Element(count)
    }
}
