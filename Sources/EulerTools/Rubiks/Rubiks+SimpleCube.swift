public extension Rubiks {
    /**
     Simple representation for cube with each face as a 3x3 grid of squares [0,1,2] + [3,4,5] + [6,7,8]
     and the faces in order: up, front, left, back, right, down

     The idea is to have something easy to reason about and manipulate, and then convert to a more compact representation
     */
    struct SimpleCube: Sendable {
        public typealias Color = Rubiks.Color
        public typealias Face = Rubiks.Face
        public typealias Index = SimpleIndex
        public var data: [Color]

        public static let starting = Rubiks.Face.allCases.flatMap { face in
            Array(repeating: face.startingColor, count: 9)
        }

        public init(data: [Color] = Self.starting) {
            self.data = data
        }
    }

    enum SimpleCubie: CaseIterable, CustomStringConvertible, Sendable {
        case W0, W1, W2, W3, W4, W5, W6, W7, W8
        case R0, R1, R2, R3, R4, R5, R6, R7, R8
        case G0, G1, G2, G3, G4, G5, G6, G7, G8
        case O0, O1, O2, O3, O4, O5, O6, O7, O8
        case B0, B1, B2, B3, B4, B5, B6, B7, B8
        case Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8

        public static let starting = allCases

        public var description: String { String(describing: self) }
    }
}
