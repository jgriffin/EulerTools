//
//  Letter.swift
//
//
//  Created by Griff on 11/26/20.
//

import Foundation

/**
 Abstraction over Character and Ascii for puzzles where we're interested in Ascii characters
 */
public protocol Letter: Hashable, Comparable {
    static var uppercaseLetters: [Self] { get }
    static var lowercaseLetters: [Self] { get }
    static var alphaLetters: [Self] { get }
    static var numericLetters: [Self] { get }
    static var alphaNumericLetters: [Self] { get }
    static var punctuationLetters: [Self] { get }
    static var symbolLetters: [Self] { get }
    static var hexLetters: [Self] { get }

    // alpha, numeric, punctuation, space
    static var textualLetters: [Self] { get }
    var isTextual: Bool { get }

    // fairly inclusive set, including .newline, but excluding other
    // control characters like backspace and tab
    static var asciiValues: [Self] { get }

    static var newline: Self { get }
    static var space: Self { get }
    static var underscore: Self { get }

    var asCharacter: Character { get }
    var asPrintableCharacter: Character { get }

    var asAsciiCharacter: Character? { get }
    var asDigitValue: UInt8? { get }
    var asHexDigitValue: UInt8? { get }
}

// MARK: - sets and dictionaries

public extension Set where Element: Letter {
    static var isAsciiValue: Self { Element.asciiValues.asSet }
    static var isUppercase: Self { Element.uppercaseLetters.asSet }
    static var isLowercase: Self { Element.lowercaseLetters.asSet }
    static var isAlpha: Self { Element.alphaLetters.asSet }
    static var isNumeric: Self { Element.numericLetters.asSet }
    static var isAlphaNumeric: Self { Element.alphaNumericLetters.asSet }
    static var isTextual: Self { Element.textualLetters.asSet }
}

public extension Dictionary where Key: Letter, Key == Value {
    static var toUppercase: Self { Dictionary(uniqueKeysWithValues: zip(Key.lowercaseLetters, Key.uppercaseLetters)) }
    static var toLowercase: Self { Dictionary(uniqueKeysWithValues: zip(Key.uppercaseLetters, Key.lowercaseLetters)) }
}

public extension Letter {
    static var toUppercaseMap: [Self: Self] { .toUppercase }
    static var toLowercaseMap: [Self: Self] { .toLowercase }

    var asAsciiCharacter: Character? {
        Set<Self>.isAsciiValue.contains(self) ? asCharacter : nil
    }
}

// MARK: - Character

// can't make conformance public ... but caller can
extension Character: Letter {}

public extension Character {
    static let asciiValues: [Character] = Ascii.asciiValues.map(\.asCharacter)
    static let newline: Character = "\n"
    static let space: Character = " "
    static let underscore: Character = "_"

    static let lf: Character = "\u{2424}"
    static let printableInvalid: Character = "·"

    static let uppercaseLetters: [Character] = asciiValues.filter(\.isUppercase)
    static let lowercaseLetters: [Character] = asciiValues.filter(\.isLowercase)
    static let alphaLetters: [Character] = asciiValues.filter(\.isLetter)
    static let numericLetters: [Character] = asciiValues.filter(\.isNumber)
    static let alphaNumericLetters: [Character] = alphaLetters + numericLetters
    static let punctuationLetters: [Character] = asciiValues.filter(\.isPunctuation)
    static let symbolLetters: [Character] = asciiValues.filter(\.isSymbol)
    static let hexLetters: [Character] = "0123456789abcdef".asCharacters

    static let textualLetters: [Character] = [space] + alphaNumericLetters + "!'"
    static let isTextualSet: Set<Character> = .isTextual
    var isTextual: Bool { Self.isTextualSet.contains(self) }

    var asCharacter: Character { self }
    var asPrintableCharacter: Character {
        switch self {
        case .newline:
            return .lf
        case _ where !Set<Character>.isAsciiValue.contains(self):
            return .printableInvalid
        default:
            return self
        }
    }

    var asDigitValue: UInt8? { wholeNumberValue.flatMap(UInt8.init) }
    var asHexDigitValue: UInt8? { hexDigitValue.flatMap(UInt8.init) }
}

public extension [Character] {
    var asString: String { String(self) }
}

// MARK: - ASCII

public typealias Ascii = UInt8

// can't make conformance public ... but caller can
extension Ascii: Letter {}

public extension Ascii {
    static let asciiValues: [Ascii] = [10] + (32 ... 126).asArray
    static let newline: Ascii = Character.newline.asciiValue!
    static let space: Ascii = Character.space.asciiValue!
    static let underscore: Ascii = Character.underscore.asciiValue!

    init(_ ch: Character) { self = ch.asciiValue! }
    static let A: Ascii = Self("A")
    static let dot: Ascii = Self(".")
    static let singleQuote: Ascii = Self("'")
    static let quote: Ascii = Self("\"")

    static let uppercaseLetters: [Ascii] = try! Character.uppercaseLetters.asAscii
    static let lowercaseLetters: [Ascii] = try! Character.lowercaseLetters.asAscii
    static let alphaLetters: [Ascii] = try! Character.alphaLetters.asAscii
    static let numericLetters: [Ascii] = try! Character.numericLetters.asAscii
    static let alphaNumericLetters: [Ascii] = try! Character.alphaNumericLetters.asAscii
    static let punctuationLetters: [Ascii] = try! Character.punctuationLetters.asAscii
    static let symbolLetters: [Ascii] = try! Character.symbolLetters.asAscii
    static let hexLetters: [Ascii] = try! Character.hexLetters.asAscii

    static let textualLetters: [Ascii] = try! Character.textualLetters.asAscii
    static let isTextualSet: Set<Ascii> = .isTextual
    var isTextual: Bool { Self.isTextualSet.contains(self) }

    var asCharacter: Character { Character(UnicodeScalar(self)) }
    var asPrintableCharacter: Character { asCharacter.asPrintableCharacter }

    var asDigitValue: UInt8? {
        switch self {
        case 48 ... 57: self - 48
        default: nil
        }
    }

    var asHexDigitValue: UInt8? {
        switch self {
        case 48 ... 57: self - 48
        case 65 ... 72: self - 65 + 10
        case 97 ... 102: self - 97 + 10
        default: nil
        }
    }

    var isValidAscii: Bool { (32 ... 126).contains(self) || self == 10 }
}
