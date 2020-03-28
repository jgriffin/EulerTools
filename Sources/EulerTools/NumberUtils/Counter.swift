//
//  Counter.swift
//  ProjectEuler
//
//  Created by John Griffin on 9/29/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

public struct Counter {
    public init() {}
    var trueCount: Int = 0
    var totalCount: Int = 0

    public mutating func count(_ isTrue: Bool) {
        trueCount += isTrue ? 1 : 0
        totalCount += 1
    }

    public var trueRatio: Float {
        guard totalCount > 0 else { return .nan }
        return Float(trueCount) / Float(totalCount)
    }
}

extension Counter: CustomStringConvertible {
    public var description: String {
        let roundRatio = String(format: "%0.4f", (trueRatio * 1000).rounded() / 1000)
        return "\(trueCount) / \(totalCount) = \(roundRatio)"
    }
}
