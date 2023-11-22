import Foundation

public enum Wordlist: String, CaseIterable, LoadableResource {
    case english_words_alpha = "english_words_alpha.txt"
    case mit_wordlist_10000 = "mit_wordlist_10000.txt"
    case unix_words = "unix_words.txt"
    case unix_propernames = "unix_propernames.txt"
    // case anEnglishWordList = "AnEnglishWordList.txt"
    case top12ThousantProbable = "Top12Thousand-probable-v2.txt"
    case wordle = "wordle.txt"

    // http://www.gwicks.net/dictionaries.htm

    public var resourceURL: URL {
        get throws {
            guard let url = Bundle.module.url(forResource: rawValue, withExtension: nil) else {
                throw ResourceError.resourceNotFound
            }
            return url
        }
    }
}

public enum CocoaWordlists: String, CaseIterable, LoadableResource {
    case coca_acad = "text_acad.txt"
    case coca_blog = "text_blog.txt"
    // case coca_fic = "text_fic.txt"
    case coca_mag = "text_mag.txt"
    case coca_news = "text_news.txt"
    case coca_spok = "text_spok.txt"
    // case coca_tvm = "text_tvm.txt"
    case coca_web = "text_web.txt"

    public var resourceURL: URL {
        get throws {
            guard let url = Bundle.module.url(forResource: rawValue, withExtension: nil) else {
                throw ResourceError.resourceNotFound
            }
            return url
        }
    }
}

public protocol LoadableResource {
    var resourceURL: URL { get throws }
}

public extension LoadableResource {
    var data: Data {
        get throws {
            try Data(contentsOf: resourceURL)
        }
    }

    var asString: String {
        get throws {
            try String(contentsOf: resourceURL, encoding: .utf8)
        }
    }
}

enum ResourceError: Error {
    case resourceNotFound
}
