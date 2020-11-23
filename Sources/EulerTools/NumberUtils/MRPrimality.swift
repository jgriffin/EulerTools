//
//  MRPrimality.swift
//
//
//  Created by Sahn Cha on 2016. 10. 18..
//
//
import Foundation

extension Primes {
    public enum MillerRabinError: Error {
        case primeLowAccuracy
        case primeLowerBorder
        case uIntOverflow
    }

    /*
     The Miller–Rabin test relies on an equality or set of equalities that
     hold true for prime values, then checks whether or not they hold for
     a number that we want to test for primality.
     - Parameter n: an odd integer to be tested for primality;
     - Parameter k: a parameter that determines the accuracy of the test
     - throws: Can throw an error of type `MillerRabinError`.
     - Returns: composite if n is composite, otherwise probably prime
     */
    public static func checkWithMillerRabin(_ n: UInt) throws -> Bool {
        guard n > 0 else { throw MillerRabinError.primeLowerBorder }

        if n == 2 || n == 3 || n == 5 {
            return true
        }
        if n % 2 == 0 || n % 3 == 0 || n % 5 == 0 {
            return false
        }

        guard let witnesses = potentialWitnesses(for: n) else {
            throw MillerRabinError.primeLowAccuracy
        }

        let s = UInt((n - 1).trailingZeroBitCount)
        let d: UInt = (n - 1) >> s

        guard UInt(pow(2.0, Double(s))) * d == n - 1 else { throw MillerRabinError.primeLowerBorder }

        /// Inspect whether a given witness will reveal the true identity of n.
        func tryComposite(_ a: UInt, d: UInt, n: UInt) throws -> Bool? {
            var x = try calculateModularExponentiation(base: a, exponent: d, modulus: n)
            if x == 1 || x == (n - 1) {
                return nil
            }
            for _ in 1 ..< s {
                x = try calculateModularExponentiation(base: x, exponent: 2, modulus: n)
                if x == 1 {
                    return false
                } else if x == (n - 1) {
                    return nil
                }
            }
            return false
        }

        for a in witnesses {
            if let composite = try tryComposite(a, d: d, n: n) {
                return composite
            }
        }

        return true
    }

    /*
     Calculates the modular exponentiation based on `Applied Cryptography by Bruce Schneier.`
     in `Schneier, Bruce (1996). Applied Cryptography: Protocols, Algorithms,
     and Source Code in C, Second Edition (2nd ed.). Wiley. ISBN 978-0-471-11709-4.`
     - Parameter base: The natural base b.
     - Parameter base: The natural exponent e.
     - Parameter base: The natural modulus m.
     - Throws: Can throw a `uIntOverflow` if the modulus' square exceeds the memory
     limitations of UInt on the current system.
     - Returns: The modular exponentiation c.
     */
    private static func calculateModularExponentiation(base: UInt, exponent: UInt, modulus: UInt) throws -> UInt {
        guard modulus > 1 else { return 0 }
        guard !(modulus - 1).multipliedReportingOverflow(by: modulus - 1).overflow else {
            throw MillerRabinError.uIntOverflow
        }

        var result: UInt = 1
        var exponentCopy = exponent
        var baseCopy = base % modulus

        while exponentCopy > 0 {
            if exponentCopy % 2 == 1 {
                result = (result * baseCopy) % modulus
            }
            exponentCopy = exponentCopy >> 1
            baseCopy = (baseCopy * baseCopy) % modulus
        }

        return result
    }

    private static func potentialWitnesses(for n: UInt) -> [UInt]? {
        // values from https://en.wikipedia.org/wiki/Miller–Rabin_primality_test
        switch n {
        case _ where n < 2047:
            return [2]
        case _ where n < 1_373_653:
            return [2, 3]
        case _ where n < 9_080_191:
            return [31, 73]
        case _ where n < 25_326_001:
            return [2, 3, 5]
        case _ where n < 3_215_031_751:
            return [2, 3, 5, 7]
        case _ where n < 4_759_123_141:
            return [2, 7, 61]
        case _ where n < 1_122_004_669_633:
            return [2, 13, 23, 1_662_803]
        case _ where n < 2_152_302_898_747:
            return [2, 3, 5, 7, 11]
        case _ where n < 3_474_749_660_383:
            return [2, 3, 5, 7, 11, 13]
        case _ where n < 341_550_071_728_321:
            return [2, 3, 5, 7, 11, 13, 17]
        default:
            return nil
        }
    }
}
