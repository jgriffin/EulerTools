//
//  Sequence+.swift
//
//
//  Created by John Griffin on 4/19/20.
//

import Foundation

public extension Sequence {
    func any() -> AnySequence<Self.Element> {
        AnySequence<Self.Element>(self)
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

public extension Sequence<Character> {
    var asString: String { String(self) }
}

public extension Sequence<String> {
    var joinedByNewlines: String {
        joined(separator: "\n")
    }
}

public extension Sequence where Element: CustomStringConvertible {
    var joinedByNewlines: String {
        map(String.init).joinedByNewlines
    }
}
