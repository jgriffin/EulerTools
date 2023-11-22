//
// Created by John Griffin on 11/20/23
//

import Algorithms
import Foundation

/**
 P(A|B) = P(B|A) * P(A) / P(B)
 */
public struct Bayesian<B: Hashable> {
    let probBGivenA: (B) -> Float
    let probB: (B) -> Float

    public init(
        probBGivenA: @escaping (B) -> Float,
        probB: @escaping (B) -> Float
    ) {
        self.probBGivenA = probBGivenA
        self.probB = probB
    }

    public func probA(_ priorA: Float, givenB b: B) -> Float {
        let pBGivenA = probBGivenA(b)
        let pB = probB(b)
        let pA = pBGivenA * priorA / pB
        return pA
    }

    public func probA(_ priorA: Float, givenBs: some Sequence<B>) -> Float {
        givenBs.reduce(priorA) { priorA, b in
            probA(priorA, givenB: b)
        }
    }

    public func probAReductions(_ priorA: Float, givenBs: some Sequence<B>) -> [Float] {
        givenBs.reductions(priorA) { priorA, b in
            probA(priorA, givenB: b)
        }
    }
}
