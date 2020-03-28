//
//  Numeric.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/28/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

extension Numeric where Self: Comparable {
    public func isBetween(lower: Self, upper: Self) -> Bool {
        return lower <= self && self < upper
    }

    public func isBetween(lower: Self, upperIncl: Self) -> Bool {
        return lower <= self && self <= upperIncl
    }

    public func makeBetween(lower: Self, upperIncl: Self) -> Self {
        guard lower < upperIncl else {
            fatalError()
        }

        if self < lower {
            return lower
        } else if upperIncl < self {
            return upperIncl
        }
        return self
    }
}
