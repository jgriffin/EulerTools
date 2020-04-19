//
//  ContinuedFraction.swift
//
//
//  Created by John Griffin on 4/19/20.
//

import Foundation

public typealias ContinuedFraction = ContinuedFractional<Int>

public struct ContinuedFractional<T: SignedInteger> {
    public typealias Frac = Fractional<T>

    public let sequence: AnySequence<T>

    public init(_ sequence: AnySequence<T>) {
        self.sequence = sequence
    }

    public func expansion(maxTerms: Int = 100) -> Frac {
        let expansion = sequence.prefix(maxTerms)
            .reversed()
            .reduce(nil as Frac?) { (result, term) -> Frac in
                Frac(term) + (result?.reciprocal ?? 0)
            }

        return expansion ?? 0
    }
}

extension ContinuedFractional {
    public init(_ sequence: [T]) {
        self.init(sequence.any())
    }

    public init(whole: T, _ fractional: AnySequence<T>) {
        self.init(.join([whole].any(), fractional))
    }

    public init(whole: T, _ fractional: [T]) {
        self.init(([whole] + fractional).any())
    }
}
