//
// Created by John Griffin on 11/12/23
//

import Foundation

public struct ElementCounts<Element: Hashable>: CustomStringConvertible {
    public let countOf: [Element: Int]

    // pre-computed
    public let totalCount: Int
    public let uniqueCount: Int

    public init(countOf: [Element: Int]) {
        self.countOf = countOf
        totalCount = countOf.values.reduce(0,+)
        uniqueCount = countOf.keys.count
    }

    public init(_ s: some Sequence<Element>) {
        self.init(countOf:
            s.reduce(into: [Element: Int]()) { counts, char in
                counts[char, default: 0] += 1
            }
        )
    }

    public var description: String {
        "\(counts: self, prefix: 5)"
    }
}

public extension ElementCounts {
    // MARK: - map

    func map(_ mapper: ElementMapper<Element>) -> ElementCounts {
        .init(countOf:
            countOf.reduce(into: [Element: Int]()) { partialResult, pair in
                guard let letter = mapper.mapping(pair.key) else { return }
                partialResult[letter, default: 0] += pair.value
            }
        )
    }

    // MARK: - probabilities

    func probabilityOf(_ element: Element) -> Float {
        Float(countOf[element, default: 0]) / Float(totalCount)
    }

    func laplaceOf(_ element: Element) -> Float {
        Float(countOf[element, default: 0] + 1) / Float(totalCount + uniqueCount)
    }

    // MARK: - elements

    var elements: Set<Element> {
        countOf.keys.asSet
    }

    func elementsSortedByCount(ascending: Bool = false) -> [Element] {
        countOf
            .sorted(by: ascending ? Self.isAscending : Self.isDescending)
            .map(\.key)
    }

    typealias KeyAndCount = (key: Element, value: Int)

    private static func isAscending(_ lhs: KeyAndCount, _ rhs: KeyAndCount) -> Bool {
        lhs.value < rhs.value
    }

    private static func isDescending(_ lhs: KeyAndCount, _ rhs: KeyAndCount) -> Bool {
        lhs.value > rhs.value
    }

    // MARK: - map to

    typealias ElementAndFloat = (element: Element, value: Float)

    func map(elements: [Element], with: (Element) -> Float) -> [ElementAndFloat] {
        elements.map { element in
            ElementAndFloat(element, with(element))
        }
    }
}

public extension ElementCounts where Element: Comparable {
    typealias SortsBeforeCount = ((key: Element, value: Int), (key: Element, value: Int)) -> Bool
    static var increasingCountsByLetter: SortsBeforeCount { { $0.key < $1.key } }
    static var decreasingCountsByLetter: SortsBeforeCount { { $0.key > $1.key } }

    typealias SortsBeforePercentage = ((key: Element, value: Float), (key: Element, value: Float)) -> Bool
    static var increasingPrecentageByLetter: SortsBeforePercentage { { $0.value < $1.value } }
    static var decreasingPercentageByLetter: SortsBeforePercentage { { $0.value > $1.value } }
}
