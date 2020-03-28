//
//  File.swift
//
//
//  Created by John Griffin on 3/14/20.
//

import Foundation

extension Array {
    func chunked(by chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: chunkSize)
            .map {
                let last = Swift.min($0 + chunkSize, self.count)
                return Array(self[$0 ..< last])
            }
    }
}
