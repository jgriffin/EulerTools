//
//  AnySequence+extensions.swift
//
//
//  Created by John Griffin on 4/19/20.
//

import Foundation

public extension Sequence {
    func any() -> AnySequence<Self.Element> {
        AnySequence<Self.Element>(self)
    }

    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        sorted { a, b in
            a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }

    var asArray: [Element] { Array(self) }
}

public extension AnySequence {
    static func join(_ seqs: AnySequence...) -> Self {
        seqs.joined().any()
    }
}

public extension Sequence where Element: Hashable {
    var asSet: Set<Element> { Set(self) }
}

public extension Sequence where Element == Character {
    var asString: String { String(self) }
}

public extension Sequence where Element: CustomStringConvertible {
    var asString: String {
        map(String.init).joined(separator: "n")
    }
}
