//
// Created by John Griffin on 11/19/23
//

import EulerTools
import XCTest

final class LetterTests: XCTestCase {
    func testLetters() async throws {
        XCTAssertEqual(Character.asciiValues.asString, "\n" + ##" !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~"##)
        XCTAssertEqual(Character.lowercaseLetters.asString, "abcdefghijklmnopqrstuvwxyz")
        XCTAssertEqual(Character.uppercaseLetters.asString, "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        XCTAssertEqual(Character.alphaLetters.asString, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        XCTAssertEqual(Character.digitLetters.asString, "0123456789")
        XCTAssertEqual(Character.alphaDigitLetters.asString, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
        XCTAssertEqual(Character.punctuationLetters.asString, ##"!"#%&'()*,-./:;?@[\]_{}"##)
        XCTAssertEqual(Character.symbolLetters.asString, "$+<=>^`|~")
        XCTAssertEqual(Character.textualLetters.asString, ###" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!'"###)
    }
}
