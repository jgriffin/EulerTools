//
// Created by John Griffin on 11/17/23
//

import Foundation

public extension String.StringInterpolation {
    mutating func appendInterpolation(heading: String) {
        appendLiteral("\(heading)\n")
        appendLiteral("\(String(repeating: "-", count: heading.count))")
    }
}
