//
//
// Created by John Griffin on 12/11/21
//

import Algorithms
import Foundation

// MARK: - Index Ranges

public protocol Indexable2Ranges {
    associatedtype Index: Indexable2

    func isValidIndex(_ index: Index) -> Bool
    func allIndices() -> [[Index]]
    func allIndicesFlat() -> [Index]
}

public extension Indexable2Ranges {
    func allIndicesFlat() -> [Index] {
        allIndices().flatMap { $0 }
    }

    func mapIndices<RowOutput>(_ block: ([Index]) -> RowOutput) -> [RowOutput] {
        allIndices().map { block($0) }
    }

    func flatMapIndices<IndexOutput>(_ block: (Index) -> IndexOutput) -> [IndexOutput] {
        allIndicesFlat().map { block($0) }
    }
}

public extension Indexable2Ranges {
    func dump(_ stringAtIndex: (Index) -> String) -> String {
        mapIndices {
            $0.map(stringAtIndex).joined()
        }.joinedByNewlines
    }

    func dump<Value>(
        valueAtIndex: (Index) -> Value,
        stringForValue: (Value) -> String
    ) -> String {
        dump { index in stringForValue(valueAtIndex(index)) }
    }

    func dump(
        _ isTrueAt: (Index) -> Bool,
        trueString: String = "X",
        falseString: String = "."
    ) -> String {
        dump(valueAtIndex: isTrueAt) { $0 ? trueString : falseString }
    }

    func dumpNS(
        _ isTrueAt: (Index) -> Bool,
        trueString: String = "X",
        falseString: String = "."
    ) -> NSString {
        dump(isTrueAt, trueString: trueString, falseString: falseString) as NSString
    }
}

// MARK: - IndexXYRanges

public struct IndexXYRanges: Indexable2Ranges {
    public typealias Index = IndexXY

    public let x: Range<Int>
    public let y: Range<Int>

    public func isValidIndex(_ index: Index) -> Bool {
        x.contains(index.x) && y.contains(index.y)
    }

    public func allIndices() -> [[Index]] {
        y.map { y in x.map { x in IndexXY(x, y) }}
    }
}

// MARK: - IndexRCRanges

public struct IndexRCRanges: Indexable2Ranges {
    public typealias Index = IndexRC

    public let r: Range<Int>
    public let c: Range<Int>

    public func isValidIndex(_ index: IndexRC) -> Bool {
        r.contains(index.r) && c.contains(index.c)
    }

    public func allIndices() -> [[IndexRC]] {
        r.map { r in c.map { c in IndexRC(r, c) }}
    }
}

public struct Ranger<Index: Indexable2> {
    public var minIndex = Index(.max, .max)
    public var maxIndex = Index(.min, .min)

    public init() {}

    public init(_ s: some Sequence<Index>) {
        for index in s {
            expand(toInclude: index)
        }
    }

    public var rangesXY: IndexXYRanges {
        IndexXYRanges(
            x: minIndex.first ..< maxIndex.first + 1,
            y: minIndex.second ..< maxIndex.second + 1
        )
    }

    public var rangesRC: IndexRCRanges {
        IndexRCRanges(
            r: minIndex.first ..< maxIndex.first + 1,
            c: minIndex.second ..< maxIndex.second + 1
        )
    }

    public mutating func expand(toInclude i: Index) {
        minIndex = Index(min(minIndex.first, i.first), min(minIndex.second, i.second))
        maxIndex = Index(max(maxIndex.first, i.first), max(maxIndex.second, i.second))
    }

    public mutating func addPadding(_ padding: Int) {
        expand(toInclude: minIndex - (padding, padding))
        expand(toInclude: maxIndex + (padding, padding))
    }
}

public extension RandomAccessCollection
    where Indices == Range<Int>, Element: RandomAccessCollection, Element.Indices == Range<Int>
{
    // MARK: - IndexXY

    var indexXYRanges: IndexXYRanges {
        .init(x: first!.indices, y: indices)
    }

    subscript(indexXY: IndexXY) -> Element.Element where Self: MutableCollection, Element: MutableCollection {
        get { self[indexXY.y][indexXY.x] }
        set { self[indexXY.y][indexXY.x] = newValue }
    }

    subscript(indexXY: IndexXY) -> Element.Element {
        self[indexXY.y][indexXY.x]
    }

    // MARK: - IndexRC

    var indexRCRanges: IndexRCRanges {
        .init(r: indices, c: first!.indices)
    }

    subscript(indexRC: IndexRC) -> Element.Element where Self: MutableCollection, Element: MutableCollection {
        get { self[indexRC.r][indexRC.c] }
        set { self[indexRC.r][indexRC.c] = newValue }
    }

    subscript(indexRC: IndexRC) -> Element.Element {
        self[indexRC.r][indexRC.c]
    }
}
