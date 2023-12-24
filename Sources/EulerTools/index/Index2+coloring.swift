//
//  Index2+coloring.swift
//
//
//  Created by Griff on 12/23/23.
//

import Foundation

public extension IndexRCRanges {
    func connectedGroupsByIndex(
        isEdge: (IndexRC) -> Bool
    ) -> [IndexRC: Int] {
        let nonEdgeIndices = allIndicesFlat().filter { !isEdge($0) }

        typealias Color = Int
        var currentColor: Color = 0
        func nextColor() -> Color {
            currentColor += 1
            return currentColor
        }

        var colorOfIndex = [IndexRC: Color]()
        var mapColorToLower: [Int: Int] = [:]

        func neighborColors(of index: IndexRC) -> [Color] {
            [Direction2.up, .right, .down, .left]
                .compactMap {
                    isValidIndex(index + $0) ? colorOfIndex[index + $0] : 0
                }
                .asSet
                .sorted()
        }

        nonEdgeIndices.forEach { g in
            let colors = neighborColors(of: g)
            switch colors.count {
            case 0:
                colorOfIndex[g] = nextColor()
            case 1:
                colorOfIndex[g] = colors.first!
            default:
                let first = colors.first!
                colorOfIndex[g] = first
                colors.dropFirst().forEach { color in
                    mapColorToLower[color] = min(first, mapColorToLower[color, default: .max])
                }
            }
        }

        var wasColorOf = colorOfIndex
        repeat {
            wasColorOf = colorOfIndex
            colorOfIndex = colorOfIndex.mapValues { color in
                mapColorToLower[color] ?? color
            }

        } while wasColorOf != colorOfIndex

        return colorOfIndex
    }

    func connectedGroupsByColor(isEdge: (IndexRC) -> Bool) -> [Int: [IndexRC]] {
        let colorByIndex = connectedGroupsByIndex(isEdge: isEdge)
        let groupedByColor = colorByIndex.reduce(into: [Int: [IndexRC]]()) { result, indexColor in
            result[indexColor.value, default: []].append(indexColor.key)
        }
        return groupedByColor
    }

    func isIndex(
        _ index: IndexRC,
        inside loopEdges: Set<IndexRC>,
        direction _: Direction2 = .left
    ) -> Bool? {
        do {
            var edgeCount = 0

            var wasEdge = false
            var cur = index
            while isValidIndex(cur) {
                if loopEdges.contains(cur) {
                    guard !wasEdge else {
                        // along the edge is ambiguous, so we punt
                        return nil
                    }
                    edgeCount += 1
                    wasEdge = true
                } else {
                    wasEdge = false
                }
                cur += .left
            }

            return edgeCount % 2 == 1
        }
    }
}
