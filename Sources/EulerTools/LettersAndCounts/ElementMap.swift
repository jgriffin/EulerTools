//
// Created by John Griffin on 11/16/23
//

import Foundation

public struct ElementMapper<Element: Hashable> {
    public let mapping: (Element) -> Element?

    public init(_ mapping: @escaping (Element) -> Element?) {
        self.mapping = mapping
    }
}

public extension ElementMapper {
//    static func map(_ mapping: @escaping (Element) -> Element?) -> Self {
//        .init(mapping)
//    }

    static func mapOrPass(_ mapping: @escaping (Element) -> Element?) -> Self {
        .init { mapping($0) ?? $0 }
    }

    static func include(_ isIncluded: @escaping (Element) -> Bool) -> Self {
        .init { isIncluded($0) ? $0 : nil }
    }

    static func exclude(_ isExcluded: @escaping (Element) -> Bool) -> Self {
        .init { isExcluded($0) ? nil : $0 }
    }

    static func always(_ output: Element?) -> Self {
        .init { _ in output }
    }
}

public extension ElementMapper {
    static func first(_ mappers: Self ...) -> Self {
        .init {
            for mapper in mappers {
                if let output = mapper.mapping($0) {
                    return output
                }
            }
            return nil
        }
    }

    static func chain(_ mappers: Self ...) -> Self {
        .init {
            mappers.reduce($0 as Element?) { output, nextMapper in
                output.flatMap(nextMapper.mapping)
            }
        }
    }

    func then(_ nextMapper: Self) -> Self {
        .chain(self, nextMapper)
    }
}

public extension ElementMapper {
    static func mapOrPass(_ mapper: Self) -> Self {
        .mapOrPass(mapper.mapping)
    }

    static func map(_ dictionary: [Element: Element]) -> Self {
        .init { dictionary[$0] }
    }

    static func mapOrPass(_ dictionary: [Element: Element]) -> Self {
        .mapOrPass { dictionary[$0] ?? $0 }
    }

    static func map(_ mapping: some Sequence<(Element, Element)>) -> Self {
        .map(Dictionary(uniqueKeysWithValues: mapping))
    }

    static func mapOrPass(_ mapping: some Sequence<(Element, Element)>) -> Self {
        .mapOrPass(.map(Dictionary(uniqueKeysWithValues: mapping)))
    }

    static func include(_ isIncluded: Set<Element>) -> Self {
        .include(isIncluded.contains)
    }

    static func exclude(_ isExcluded: Set<Element>) -> Self {
        .exclude(isExcluded.contains)
    }

    static func exclude(_ element: Element) -> Self {
        .exclude { $0 == element }
    }

    static func replaceIn(_ isIn: Set<Element>, with: Element) -> Self {
        .mapOrPass(
            .include(isIn).then(always(with))
        )
    }

    static func replaceNotIn(_ notIn: Set<Element>, with: Element) -> Self {
        .mapOrPass(
            .exclude(notIn).then(always(with))
        )
    }
}

public extension Sequence where Element: Hashable {
    func compactMap(_ mapper: ElementMapper<Element>) -> [Element] {
        compactMap(mapper.mapping)
    }
}
