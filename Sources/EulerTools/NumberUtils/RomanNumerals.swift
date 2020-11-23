//
//  RomanNumerals.swift
//  ProjectEuler
//
//  Created by John Griffin on 3/31/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

public class RomanNumerals {
    public static let romanValues: [(char: Character, val: Int)] =
        zip("MDCLXVI",
            [1000, 500, 100, 50, 10, 5, 1])
        .map { ($0, $1) }

    public static let romanSubtractiveValues: [(val: Int, chars: String)] =
        zip([1000, 900, 800, 500, 400, 100, 90, 80, 50, 40, 10, 9, 8, 5, 4, 1],
            ["M", "CM", "DCCC", "D", "CD", "C", "XC", "LXXX", "L", "XL", "X", "IX", "VIII", "V", "IV", "I"])
        .map { arg in
            let (v, c) = arg
            return (v, c)
        }

    public static func intValue<T: BidirectionalCollection>(of roman: T) -> Int where T.Element == String.Element {
        roman.reduce(0) { result, ch in
            guard let v = romanValues.first(where: { $0.char == ch })?.val else { fatalError() }
            let inc = v - 2 * (result % v)
            return result + inc
        }
    }

    public static func romanValue(of n: Int) -> String {
        var result: String = ""
        var remain = n
        while remain > 0 {
            guard let rsv = romanSubtractiveValues.first(where: { $0.val <= remain }) else {
                fatalError()
            }
            result.append(rsv.chars)
            remain -= rsv.val
        }
        return result
    }
}
