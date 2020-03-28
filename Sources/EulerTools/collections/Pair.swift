//
//  Pair.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/25/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

public struct Pair<T: Hashable, U: Hashable>: Hashable {
    public let first: T
    public let second: U
    public init(_ first: T, _ second: U) {
        self.first = first
        self.second = second
    }
}
