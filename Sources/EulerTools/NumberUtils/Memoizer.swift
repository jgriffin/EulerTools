//
//  Memoizer.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/18/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

public class Memoizer<N: Hashable, Result> {
    public typealias FN = () -> Result
    private var memos = [N: Result]()

    public init() {}

    public func memoized(_ n: N, _ fn: FN) -> Result {
        if let result = memos[n] {
            return result
        }

        let result = fn()
        memos[n] = result
        return result
    }
}
