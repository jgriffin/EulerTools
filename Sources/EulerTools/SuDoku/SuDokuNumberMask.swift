//
//  SuDokuGridTile.swift
//  ProjectEuler
//
//  Created by John Griffin on 5/10/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

extension UInt16 {
    var isSingleBit: Bool {
        return self != 0 && ((self - 1) & self) == 0
    }
}

struct SuDokuNumberMask: Equatable, CustomStringConvertible, CustomDebugStringConvertible {
    var mask: UInt16 = allDigitsMask

    static let allDigitsMask: UInt16 = 1 << 9 - 1

    init() {
        mask = SuDokuNumberMask.allDigitsMask
    }

    init(value: UInt16) {
        mask = value
    }

    init(number: UInt8) {
        mask = number == 0 ? 0 : 1 << UInt8(number - 1)
    }

    var description: String {
        let bin = String(mask, radix: 2)
        return String(repeating: "0", count: 9 - bin.count) + bin
    }

    var debugDescription: String { return description }

    var singleNumber: UInt8? {
        return SuDokuNumberMask.maskToSingleNumber[mask]
    }

    private static let maskToSingleNumber: [UInt16: UInt8] = [
        1 << 0: 1,
        1 << 1: 2,
        1 << 2: 3,
        1 << 3: 4,
        1 << 4: 5,
        1 << 5: 6,
        1 << 6: 7,
        1 << 7: 8,
        1 << 8: 9,
    ]

    static func - (lhs: SuDokuNumberMask, rhs: SuDokuNumberMask) -> SuDokuNumberMask {
        return SuDokuNumberMask(value: lhs.mask & ~rhs.mask)
    }

    static func & (lhs: SuDokuNumberMask, rhs: SuDokuNumberMask) -> SuDokuNumberMask {
        return SuDokuNumberMask(value: lhs.mask & rhs.mask)
    }

    static func | (lhs: SuDokuNumberMask, rhs: SuDokuNumberMask) -> SuDokuNumberMask {
        return SuDokuNumberMask(value: lhs.mask | rhs.mask)
    }

    static func -= (lhs: inout SuDokuNumberMask, rhs: SuDokuNumberMask) {
        lhs = lhs - rhs
    }

    static func &= (lhs: inout SuDokuNumberMask, rhs: SuDokuNumberMask) {
        lhs = lhs & rhs
    }

    static func |= (lhs: inout SuDokuNumberMask, rhs: SuDokuNumberMask) {
        lhs = lhs | rhs
    }
}
