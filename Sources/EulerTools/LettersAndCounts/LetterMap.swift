//
// Created by John Griffin on 11/17/23
//

import Foundation

public typealias LetterMap<Char: Letter> = ElementMapper<Char>

public extension LetterMap {
    typealias Char = Element

    static var uppercasedOrPass: Self { .mapOrPass(.toUppercase) }
    static var uppercasedOrDrop: Self { .first(.map(.toUppercase), .include(.isUppercase)) }
    static var lowercasedOrPass: Self { .mapOrPass(.toLowercase) }
    static var lowercasedOrDrop: Self { .first(.map(.toLowercase), .include(.isLowercase)) }

    static var newlineToSpace: Self { .replaceIn([.newline], with: .space) }
}
