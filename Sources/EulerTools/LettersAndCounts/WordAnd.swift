
import Foundation

public struct WordAndLetterMask<S: StringProtocol> {
    public let word: S
    public let mask: LetterMask

    public init(_ word: S) {
        self.word = word
        mask = word.letterMask
    }
}

public struct WordAndSet<S: StringProtocol> {
    public let word: S
    public let letters: [Character]

    public init(_ word: S) {
        self.word = word
        letters = Array(word)
    }
}

public struct WordAndSorted<S: StringProtocol> {
    public let word: S
    public let sorted: [Character]

    public init(_ word: S, _ sorted: [Character]) {
        self.word = word
        self.sorted = sorted
    }
}

public extension StringProtocol {
    func wordAndLetterMask() -> WordAndLetterMask<Self> { WordAndLetterMask(self) }
    func wordAndSet() -> WordAndSet<Self> { WordAndSet(self) }

    func wordAndSorted() -> WordAndSorted<Self> {
        WordAndSorted(self, sorted())
    }
}
