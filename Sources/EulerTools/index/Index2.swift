//
//
// Created by John Griffin on 12/10/21
//

import Algorithms

// MARK: - Indexable2

// sometimes we think in terms of XY
// sometimes we think in terms of rows and columns
// but there's a lot in common between IndexXY and IndexRC, so we have Indexable2

public protocol Indexable2: Hashable, Comparable, Neighborly, CustomStringConvertible {
    associatedtype IndexRanges: Indexable2Ranges

    init(_ first: Int, _ second: Int)
    var first: Int { get }
    var second: Int { get }
}

public extension Indexable2 {
    init(_ pair: (Int, Int)) { self.init(pair.0, pair.1) }

    var description: String { "(\(first),\(second))" }

    static var zero: Self { Self(0, 0) }
    static var invalid: Self { Self(-1, -1) }

    typealias IsValidIndex = (Self) -> Bool

    static func + (lhs: Self, rhs: Self) -> Self {
        .init(lhs.first + rhs.first, lhs.second + rhs.second)
    }

    static func + (lhs: Self, offset: (Int, Int)) -> Self {
        .init(lhs.first + offset.0, lhs.second + offset.1)
    }

    static func - (lhs: Self, rhs: Self) -> Self {
        .init(lhs.first - rhs.first, lhs.second - rhs.second)
    }

    static func - (lhs: Self, offset: (Int, Int)) -> Self {
        .init(lhs.first - offset.0, lhs.second - offset.1)
    }

    static func += (lhs: inout Self, rhs: Self) { lhs = lhs + rhs }
    static func += (lhs: inout Self, offset: (Int, Int)) { lhs = lhs + offset }
    static func -= (lhs: inout Self, rhs: Self) { lhs = lhs - rhs }
    static func -= (lhs: inout Self, offset: (Int, Int)) { lhs = lhs - offset }

    /**
     Comparison of indexes (points) is a little weird anyway, but it's useful for a bunch of things, like sorting.
     And comparing points with two different components, is even stranger.

     So, define something that feels kinda natural - sort by the first component, then the second
     In particular, for RC that's rows, then columns, giving us printing order.
     For XY, it ends up left-right
     */
    static func < (lhs: Self, rhs: Self) -> Bool {
        guard lhs.first == rhs.first else { return lhs.first < rhs.first }
        return lhs.second < rhs.second
    }

    var lengthSquared: Int { first * first + second * second }

    static func manhattanDistance(_ i1: Self, _ i2: Self) -> Int {
        abs(i2.first - i1.first) + abs(i2.second - i1.second)
    }
}

// MARK: - IndexXY

public struct IndexXY: Indexable2 {
    public typealias IndexRanges = IndexXYRanges

    public let x, y: Int

    public init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    public init(x: Int, y: Int) { self.init(x, y) }

    public var first: Int { x }
    public var second: Int { y }

    public typealias IsValidIndex = (IndexXY) -> Bool

    @available(*, deprecated, renamed: "IndexXYRanges.isValidIndex")
    public static func isValidIndexFunc(_ ranges: IndexXYRanges) -> IndexXY.IsValidIndex {
        ranges.isValidIndex
    }

    @available(*, deprecated, renamed: "IndexXYRanges.allIndexXY")
    public static func allIndexXY(_ ranges: IndexXYRanges) -> [IndexXY] {
        ranges.allIndicesFlat()
    }

    public func ensureIn(_ ranges: IndexXYRanges) -> IndexXY {
        IndexXY(x: max(ranges.x.lowerBound, min(x, ranges.x.upperBound - 1)),
                y: max(ranges.y.lowerBound, min(y, ranges.y.upperBound - 1)))
    }
}

// MARK: - IndexRC

public struct IndexRC: Indexable2 {
    public typealias IndexRanges = IndexRCRanges

    public let r, c: Int

    public init(_ r: Int, _ y: Int) {
        self.r = r
        c = y
    }

    public init(r: Int, c: Int) { self.init(r, c) }

    public var first: Int { r }
    public var second: Int { c }

    public typealias IsValidIndex = (IndexRC) -> Bool

    @available(*, deprecated, renamed: "IndexRanges.isValidIndex")
    public static func isValidIndexFunc(_ ranges: IndexRCRanges) -> IndexRC.IsValidIndex {
        ranges.isValidIndex
    }

    @available(*, deprecated, renamed: "IndexRanges.allIndexRC")
    public static func allIndexRC(_ ranges: IndexRCRanges) -> [IndexRC] {
        ranges.allIndicesFlat()
    }
}
