//
//  SuDokuBoard.swift
//  ProjectEuler
//
//  Created by John Griffin on 5/11/19.
//  Copyright © 2019 Fofu Enterprises. All rights reserved.
//

import Foundation

struct SuDokuBoard: Equatable {
    let name: String
    var digits: [UInt8]

    var isSolved: Bool { return !digits.contains(0) }

    static func == (lhs: SuDokuBoard, rhs: SuDokuBoard) -> Bool {
        return lhs.digits == rhs.digits
    }
}

extension SuDokuBoard {
    static func from(string: String) -> SuDokuBoard {
        let lines = string.split(separator: "\n")
        let tiles = lines.dropFirst().flatMap { $0.utf8.map { UInt8($0) - 48 } }
        return SuDokuBoard(name: String(lines.first!), digits: tiles)
    }
}
