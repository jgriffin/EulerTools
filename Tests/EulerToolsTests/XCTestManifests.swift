import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(EulerToolsTests.allTests),
        ]
    }
#endif
