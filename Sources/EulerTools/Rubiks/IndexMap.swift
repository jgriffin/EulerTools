//
// Created by John Griffin on 12/6/23
//

import Algorithms

/**
 We're dealing with index transformations here, so think of:
 the mapped index that appears at a queried index
 */
public struct IndexMap<Index: Hashable>: CustomStringConvertible {
    public var indexAtMap: [Index: Index]

    public func indexAt(_ index: Index) -> Index {
        indexAtMap[index] ?? index
    }

    // MARK: - initialization

    public init(_ indexAtMap: [Index: Index]) {
        self.indexAtMap = indexAtMap
    }

    public init(_ uniqueFromTo: some Sequence<(Index, Index)>) {
        self.init(.init(uniqueKeysWithValues: uniqueFromTo))
    }

    public init(at: [Index], put: [Index]) {
        self.init(zip(at, put))
    }

    public init(at: [[Index]], put: [[Index]]) {
        self.init(at: at.flatMap { $0 }, put: put.flatMap { $0 })
    }

    // MARK: - resolving

    public var inverted: Self {
        .init(indexAtMap.inverted())
    }

    // MARK: - combining

    public func merge(_ maps: Self...) -> Self {
        Self.merge([self] + maps)
    }

    public func then(_ next: Self...) -> Self {
        Self.chain([self] + next)
    }

    public func inFocus(_ focus: Self) -> Self {
        Self.chain(focus, self, focus.inverted)
    }

    // MARK: - static combining

    public static func merge(_ maps: [Self]) -> Self {
        let indexAtMap = maps.map(\.indexAtMap).reduce(into: [:]) { result, map in
            result.merge(map) { _, r in
                assertionFailure("merges shouldn't conflict")
                return r
            }
        }
        return .init(indexAtMap)
    }

    public static func chain(_ maps: [Self]) -> Self {
        // the ideas is to repeatedly renormalize so the key always ends up being
        // the original starting Indices
        let indexAtMap = maps.map(\.indexAtMap).reduce([Index: Index]()) { pre, next in
            var result = [Index: Index]()
            next.forEach { nk, nv in
                result[nk] = pre[nv] ?? nv
            }
            pre.forEach { pk, pv in
                if result[pk] == nil {
                    result[pk] = pv
                }
            }
            return result
        }
        return .init(indexAtMap)
    }

    public static func merge(_ maps: Self...) -> Self { merge(maps) }

    public static func chain(_ maps: Self...) -> Self { chain(maps) }

    public var description: String { indexAtMap.description }
}

extension Dictionary where Value: Hashable {
    func inverted() -> [Value: Key] {
        .init(uniqueKeysWithValues: map { ($0.value, $0.key) })
    }
}
