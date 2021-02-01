//
//
// Created by John Griffin on 1/31/21
//

import Foundation

public struct AStarSolver<State: Hashable,
    NeighborStates: Sequence> where NeighborStates.Element == State
{
    // HScorer
    // heuristic function that estimates the cost of the cheapest path from n to the goal.
    // A* terminates when the path it chooses to extend is a path from start to goal or
    // if there are no paths eligible to be extended.
    // The heuristic function is problem-specific.
    // If the heuristic function is admissible, meaning that it never overestimates the
    // actual cost to get to the goal, A* is guaranteed to return
    // a least-cost path from start to goal.
    public typealias HScorer = (_ state: State) -> Int

    // return the legal moves from a state
    public typealias NeighborStatesGenerator = (_ state: State) -> NeighborStates

    // return the legal moves from a state
    public typealias StepCoster = (_ from: State, _ to: State) -> Int

    let hScorer: HScorer
    let neighborGenerator: NeighborStatesGenerator
    let stepCoster: StepCoster?

    public init(hScorer: @escaping HScorer,
                neighborGenerator: @escaping NeighborStatesGenerator,
                stepCoster: StepCoster? = nil)
    {
        self.hScorer = hScorer
        self.neighborGenerator = neighborGenerator
        self.stepCoster = stepCoster
    }

    // MARK: Solve

    public func solve(from start: State,
                      goal: State) -> [State]?
    {
        var cameFrom = [State: State]()

        var closedSet = Set<State>()
        var openSet = Set<State>([start])

        // cheapest path known from start so far
        var gScore: [State: Int] = [start: 0]

        // For node n, fScore[n] := gScore[n] + h(n).
        // fScore[n] represents our current best guess as to
        // how short a path from start to finish can be if it goes through n.
        var fScore: [State: Int] = [start: hScorer(start)]

        let bestOpenFScore = {
            openSet.map { ($0, fScore[$0]!) }
                .min(by: { lhs, rhs in lhs.1 < rhs.1 })
                .map(\.0)
        }

        // take lowest fScore
        while let current = bestOpenFScore() {
            if current == goal {
                return reconstuctPath(to: current,
                                      cameFrom: cameFrom)
            }

            openSet.remove(current)
            closedSet.insert(current)

            for neighbor in neighborGenerator(current) {
                guard !closedSet.contains(neighbor) else {
                    continue
                }

                let cost = stepCoster.map { $0(current, neighbor) } ?? 1
                let neighborGScore = gScore[current]! + cost
                guard neighborGScore < gScore[neighbor, default: .max] else {
                    continue
                }

                cameFrom[neighbor] = current
                gScore[neighbor] = neighborGScore
                fScore[neighbor] = neighborGScore + hScorer(neighbor)

                openSet.insert(neighbor)
            }
        }

        print("solutions not found")
        return nil
    }

    func reconstuctPath(to: State, cameFrom: [State: State]) -> [State] {
        var path = [to]
        var current = to
        while let from = cameFrom[current] {
            path.append(from)
            current = from
        }
        return path
    }
}
