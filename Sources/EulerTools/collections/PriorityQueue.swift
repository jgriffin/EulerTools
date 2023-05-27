//
//
// Created by John Griffin on 2/15/21
//

import Foundation

public class PriorityQueue<Value, Priority: Comparable> {
    public init(minQueue: Bool = true) {
        binaryHeap = BinaryHeap<PriorityNode>(minHeap: minQueue)
    }

    private var binaryHeap: BinaryHeap<PriorityNode>

    struct PriorityNode: Comparable {
        let value: Value
        let priority: Priority

        static func == (_ lhs: PriorityNode, rhs: PriorityNode) -> Bool {
            lhs.priority == rhs.priority
        }

        static func < (_ lhs: PriorityNode, rhs: PriorityNode) -> Bool {
            lhs.priority < rhs.priority
        }
    }

    // MARK: - public API

    public func enqueue(_ value: Value, priority: Priority) {
        let node = PriorityNode(value: value, priority: priority)
        binaryHeap.insert(node)
    }

    public func peekNext() -> Value? {
        guard !binaryHeap.isEmpty else { return nil }
        return binaryHeap.heap[0].value
    }

    public func popNext() -> Value? {
        guard !binaryHeap.isEmpty else { return nil }
        return binaryHeap.remove(at: 0).value
    }
}
