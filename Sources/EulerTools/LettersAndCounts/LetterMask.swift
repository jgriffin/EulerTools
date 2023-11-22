//
// Created by John Griffin on 4/1/22
//

import Foundation

public typealias LetterMask = Int32

public extension Character {
    var letterMask: LetterMask {
        guard ("a" ... "z").contains(self),
              let asciiValue else { return 0 }
        return 1 << (asciiValue - Character("a").asciiValue!)
    }
}

public extension StringProtocol {
    var letterMask: LetterMask {
        reduce(0) { result, ch in result | ch.letterMask }
    }
}
