//
//  Letter+conversions.swift
//
//
//  Created by Griff on 11/26/20.
//

import Foundation

public extension Sequence<Character> {
    var asCharacters: [Character] { Array(self) }

    var asAscii: [Ascii] {
        get throws {
            try map {
                guard let ascii = $0.asciiValue else { throw AsciiError.notValidAscii }
                return ascii
            }
        }
    }
}

public extension Sequence where Element: Letter {
    var asPrintableString: String {
        lazy.map(\.asPrintableCharacter).asString
    }

    var asCharacters: [Character] { map(\.asCharacter) }
}

public extension Sequence<Ascii> {
    func asAscii(_ newlineOptions: NewlineOptions) throws -> [Ascii] {
        guard allSatisfy(\.isValidAscii) else { throw AsciiError.notValidAscii }

        switch newlineOptions {
        case .keepNewlines: return asArray
        case .dropNewlines: return filter { $0 != .newline }
        case .newlinesToSpace: return map { $0 == .newline ? .space : $0 }
        case let .newlinesTo(char): return map { $0 == .newline ? char : $0 }
        }
    }

    func asAsciiSplitNewlines() throws -> [[Ascii]] {
        guard allSatisfy(\.isValidAscii) else { throw AsciiError.notValidAscii }
        return split(separator: .newline).map(\.asArray)
    }
}

public enum NewlineOptions {
    case keepNewlines, dropNewlines, newlinesToSpace
    case newlinesTo(Ascii)
}

enum AsciiError: Error {
    case notValidAscii
    case stringConversionFailed
}
