//
// Created by John Griffin on 12/6/23
//

import Foundation

public enum Rubiks {
    public enum Color: CaseIterable, CustomStringConvertible, Sendable {
        case w, r, g, o, b, y // white, red, green, orange, blue, yellow

        public var description: String {
            switch self {
            case .r: "r"
            case .b: "b"
            case .g: "g"
            case .o: "o"
            case .y: "y"
            case .w: "w"
            }
        }
    }

    public enum Face: CaseIterable, Sendable {
        case u, f, l, b, r, d // up, front, left, back, right, down

        public var startingColor: Color {
            switch self {
            case .u: .w
            case .f: .r
            case .l: .g
            case .b: .o
            case .r: .b
            case .d: .y
            }
        }
    }
}
