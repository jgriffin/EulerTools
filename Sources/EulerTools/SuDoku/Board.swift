//
//  SuDokuBoard.swift
//  ProjectEuler
//
//  Created by John Griffin on 5/11/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

public struct SuDoku {}

extension SuDoku {
    public typealias Digit = UInt8

    public struct Board: Equatable, CustomStringConvertible {
        public let name: String
        public var digits: [Digit]

        public var isSolved: Bool { !digits.contains(0) }

        public static func == (lhs: Board, rhs: Board) -> Bool {
            lhs.digits == rhs.digits
        }

        public static func from(string: String) -> Board {
            let lines = string.split(separator: "\n")
            let tiles = lines.dropFirst().flatMap { $0.utf8.map { UInt8($0) - 48 } }
            return Board(name: String(lines.first!), digits: tiles)
        }

        public var description: String {
            digits.chunked(by: 9)
                .map { $0.map(String.init).joined(separator: "") }
                .joined(separator: "\n")
        }
    }
}
