//
// Created by John Griffin on 5/27/23
//

public extension Int {
    func times(_ block: (Int) -> Void) {
        for i in 0 ..< self {
            block(i)
        }
    }

    func times(_ block: () -> Void) {
        for _ in 0 ..< self {
            block()
        }
    }
}
