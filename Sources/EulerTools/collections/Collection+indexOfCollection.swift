//
//
// Created on 1/24/21
//

public extension Collection where Element: Equatable {
    func firstIndex<C: Collection>(of collection: C) -> Index? where C.Element == Element {
        guard !collection.isEmpty else { return nil }
        let size = collection.count

        return indices.dropLast(size - 1).first {
            self[$0 ..< index($0, offsetBy: size)].elementsEqual(collection)
        }
    }

    func indices<C: Collection>(of collection: C) -> [Index] where C.Element == Element {
        guard !collection.isEmpty else { return [] }
        let size = collection.count

        return indices.dropLast(size - 1).filter {
            self[$0 ..< index($0, offsetBy: size)].elementsEqual(collection)
        }
    }

    func range<C: Collection>(of collection: C) -> Range<Index>? where C.Element == Element {
        guard !collection.isEmpty else { return nil }
        let size = collection.count

        var range: Range<Index>!
        guard let _ = indices.dropLast(size - 1)
            .first(where: {
                range = $0 ..< index($0, offsetBy: size)
                return self[range].elementsEqual(collection)
            })
        else {
            return nil
        }
        return range
    }

    func ranges<C: Collection>(of collection: C) -> [Range<Index>] where C.Element == Element {
        guard !collection.isEmpty else { return [] }
        let size = collection.count

        return indices.dropLast(size - 1)
            .compactMap {
                let range = $0 ..< index($0, offsetBy: size)
                return self[range].elementsEqual(collection) ? range : nil
            }
    }
}
