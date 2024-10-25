//
//
// Created by John Griffin on 2/15/21
//

import EulerTools
import XCTest

class BinaryHeapTests: XCTestCase {
    func testBinaryHeap() {
        let numbers = Array(0 ... 10)
        let shuffled = numbers.shuffled()

        var heap = BinaryHeap<Int>(minHeap: true)
        for i in shuffled {
            heap.insert(i)
        }

        let iterator = AnyIterator { () -> Int? in
            heap.removeFirst()
        }
        let result = Array(iterator)

        print(result)
    }
}
