//
//  AnySequence+extensions.swift
//
//
//  Created by John Griffin on 4/19/20.
//

import Foundation

extension Sequence {
    public func any() -> AnySequence<Self.Element> {
        AnySequence<Self.Element>(self)
    }
}

extension AnySequence {
    public static func join(_ seqs: AnySequence...) -> Self {
        seqs.joined().any()
    }
}
