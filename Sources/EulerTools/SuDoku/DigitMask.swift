//
//  SuDokuGridTile.swift
//  ProjectEuler
//
//  Created by John Griffin on 5/10/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

extension SuDoku {
    public struct DigitMask: OptionSet {
        public var rawValue: UInt16

        public init(rawValue: UInt16) { self.rawValue = rawValue }

        public init(number: Digit) {
            if number == 0 {
                rawValue = 0
            } else if number <= 9 {
                rawValue = 1 << (UInt16(number) - 1)
            } else {
                fatalError("invalid number: \(number)")
            }
        }

        public static let zero = DigitMask(rawValue: 0)
        public static let one = DigitMask(rawValue: 1 << 0)
        public static let two = DigitMask(rawValue: 1 << 1)
        public static let three = DigitMask(rawValue: 1 << 2)
        public static let four = DigitMask(rawValue: 1 << 3)
        public static let five = DigitMask(rawValue: 1 << 4)
        public static let six = DigitMask(rawValue: 1 << 5)
        public static let seven = DigitMask(rawValue: 1 << 6)
        public static let eight = DigitMask(rawValue: 1 << 7)
        public static let nine = DigitMask(rawValue: 1 << 8)

        public static let allDigits: DigitMask = [.one, .two, .three, .four, .five, .six, .seven, .eight, .nine]
    }
}

extension SuDoku.DigitMask: CustomStringConvertible {
    private var isSingleBit: Bool { return rawValue != 0 && ((rawValue - 1) & rawValue) == 0 }

    public var singleDigit: SuDoku.Digit? {
        guard isSingleBit else { return nil }
        return (1 ... 9).first { self == SuDoku.DigitMask(number: $0) }
    }

    public var availableDigits: [SuDoku.Digit] {
        return (1 ... 9).filter { self.contains(SuDoku.DigitMask(number: $0)) }
    }

    public var description: String {
        let bin = String(rawValue, radix: 2)
        return String(repeating: "0", count: 9 - bin.count) + bin
    }
}
