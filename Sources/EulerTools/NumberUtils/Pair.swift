//
//  Pair.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/25/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

struct Pair<T: Hashable, U: Hashable>: Hashable {
    let first: T
    let second: U
    init(_ first: T, _ second: U) {
        self.first = first
        self.second = second
    }
}
