import Foundation

public extension Rubiks {
    /**
     Simple representation for cube with each face as a 3x3 grid of squares [0,1,2] + [3,4,5] + [6,7,8]
     and the faces in order: up, front, left, back, right, down

     The idea is to have something easy to reason about and manipulate, and then convert to a more compact representation
     */
    enum SimpleIndex: Int, Comparable, Strideable, CustomStringConvertible, Sendable {
        case u0 = 0, u1, u2, u3, u4, u5, u6, u7, u8
        case l0, l1, l2, l3, l4, l5, l6, l7, l8
        case f0, f1, f2, f3, f4, f5, f6, f7, f8
        case r0, r1, r2, r3, r4, r5, r6, r7, r8
        case b0, b1, b2, b3, b4, b5, b6, b7, b8
        case d0, d1, d2, d3, d4, d5, d6, d7, d8
        case endInvalid // for stridable

        public var description: String {
            switch self {
            case .u0: "u0"; case .u1: "u1"; case .u2: "u2"; case .u3: "u3"; case .u4: "u4"
            case .u5: "u5"; case .u6: "u6"; case .u7: "u7"; case .u8: "u8"
            case .l0: "l0"; case .l1: "l1"; case .l2: "l2"; case .l3: "l3"; case .l4: "l4"
            case .l5: "l5"; case .l6: "l6"; case .l7: "l7"; case .l8: "l8"
            case .f0: "f0"; case .f1: "f1"; case .f2: "f2"; case .f3: "f3"; case .f4: "f4"
            case .f5: "f5"; case .f6: "f6"; case .f7: "f7"; case .f8: "f8"
            case .r0: "r0"; case .r1: "r1"; case .r2: "r2"; case .r3: "r3"; case .r4: "r4"
            case .r5: "r5"; case .r6: "r6"; case .r7: "r7"; case .r8: "r8"
            case .b0: "b0"; case .b1: "b1"; case .b2: "b2"; case .b3: "b3"; case .b4: "b4"
            case .b5: "b5"; case .b6: "b6"; case .b7: "b7"; case .b8: "b8"
            case .d0: "d0"; case .d1: "d1"; case .d2: "d2"; case .d3: "d3"; case .d4: "d4"
            case .d5: "d5"; case .d6: "d6"; case .d7: "d7"; case .d8: "d8"
            case .endInvalid: "invalid"
            }
        }

        public static let starting = (u0 ..< .endInvalid).asArray

        // MARK: - stridable

        public typealias Stride = Int
        public static func < (lhs: Self, rhs: Self) -> Bool { lhs.rawValue < rhs.rawValue }
        public func distance(to other: Self) -> Int { other.rawValue - rawValue }
        public func advanced(by n: Int) -> Self { Self(rawValue: rawValue + n) ?? .endInvalid }

        // MARK: - face indices

        public static let ups = (Self.u0 ... .u8).asArray
        public static let fronts = (Self.f0 ... .f8).asArray
        public static let lefts = (Self.l0 ... .l8).asArray
        public static let backs = (Self.b0 ... .b8).asArray
        public static let rights = (Self.r0 ... .r8).asArray
        public static let downs = (Self.d0 ... .d8).asArray

        // MARK: - moves

        public static func rotateCW(_ face: Face, _ count: Int) -> IndexMap<SimpleIndex> {
            let focus = focus(face)
            let rotateUp = rotateFocusCW(count: count)
            let combined = rotateUp.inFocus(focus)
            return combined
        }

        public static func focus(_ face: Face) -> IndexMap<SimpleIndex> {
            switch face {
            case .u:
                return .init([])
            case .f:
                let stacked = ups + fronts + downs + backs.rotatedNineCW(2)
                let colRotation = stacked.indexMapRotateCols(toStartAt: 3)
                return colRotation.merge(
                    rights.indexMapRotateCW(1),
                    lefts.indexMapRotateCW(-1)
                )
            case .l:
                let stacked = fronts + rights + backs + lefts
                let rowRotation = stacked.indexMapRotateRows(toStartAt: -3)
                let l2f = rowRotation.merge(ups.indexMapRotateCW(-1), downs.indexMapRotateCW(1))
                let f2u = focus(.f)
                let combined = l2f.then(f2u)
                return combined
            case .b:
                let stacked = fronts + rights + backs + lefts
                let rowRotation = stacked.indexMapRotateRows(toStartAt: 6)
                let l2f = rowRotation.merge(ups.indexMapRotateCW(-2), downs.indexMapRotateCW(2))
                let f2u = focus(.f)
                let combined = l2f.then(f2u)
                return combined
            case .r:
                let stacked = fronts + rights + backs + lefts
                let rowRotation = stacked.indexMapRotateRows(toStartAt: 3)
                let l2f = rowRotation.merge(ups.indexMapRotateCW(1), downs.indexMapRotateCW(-1))
                let f2u = focus(.f)
                let combined = l2f.then(f2u)
                return combined
            case .d:
                let f2u = focus(.f)
                let combined = f2u.then(f2u)
                return combined
            }
        }

        public static func rotateFocusCW(count: Int) -> IndexMap<SimpleIndex> {
            let stacked = fronts + rights + backs + lefts
            let upEdgeRotation = stacked.rowsFromNines()[0].indexMapRotate(toStartAt: 3 * count)
            return upEdgeRotation.merge(ups.indexMapRotateCW(count))
        }
    }
}

public typealias SimpleIndex = Rubiks.SimpleIndex

public extension IndexMap<SimpleIndex> {
    var dumpNines: NSString {
        SimpleIndex.starting.map(indexAt).dumpNines
    }
}

public extension [SimpleIndex] {
    // Aliases for convenience
    static let ups = SimpleIndex.ups
    static let fronts = SimpleIndex.fronts
    static let lefts = SimpleIndex.lefts
    static let backs = SimpleIndex.backs
    static let rights = SimpleIndex.rights
    static let downs = SimpleIndex.downs

    func selectOffsets(_ offsets: [Int]) -> [Element] {
        offsets.map { self[$0] }
    }

    // MARK: - moves

    func indexMapRotate(toStartAt: Int) -> IndexMap<SimpleIndex> {
        let toStartAt = toStartAt < 0 ? toStartAt + count : toStartAt
        return .init(at: self, put: self.rotated(toStartAt: toStartAt))
    }

    func indexMapRotateCW(_ count: Int) -> IndexMap<SimpleIndex> {
        assert(self.count == 9)
        return .init(at: self, put: self.rotatedNineCW(count))
    }

    func indexMapRotateRows(toStartAt: Int) -> IndexMap<SimpleIndex> {
        let rows = rowsFromNines()
        let rotated = rows.stripsRotated(toStartAt: toStartAt)
        return .init(at: rows, put: rotated)
    }

    func indexMapRotateCols(toStartAt: Int) -> IndexMap<SimpleIndex> {
        let cols = colsFromNines()
        let rotated = cols.stripsRotated(toStartAt: toStartAt)
        return .init(at: cols, put: rotated)
    }
}
